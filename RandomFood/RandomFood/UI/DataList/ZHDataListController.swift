//
//  ZHDiningRoomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import MJRefresh

class ZHDataListController: ZHBaseController {
    
    var isEdit = false
    var type: ZHRandomFoodType = .diningroom
    var endEdit = true
    
    private var page = 1
    
    private var doneBtn: UIButton?
    
    let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: ZHScreenWidth, height: ZHScreenHeight), style: .plain)
    
    var diningrooms:Array<ZHDiningRoom> = []
    var selectedrooms:Array<ZHDiningRoom> = []
    
    var foods:Array<ZHFood> = []
    
    var footerView: ZHAddNewItemView?
    var selectIndex: IndexPath?
    
    
    @objc func loadMoreData() {
        self.page += 1
        ZHLocationHelper.share.searchAround(page: self.page).subscribe(onNext: { [unowned self] (rooms) in
            self.diningrooms.append(contentsOf: rooms)
            if rooms.count < 20 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self.tableView.mj_footer.endRefreshing()
            }
            self.tableView.reloadData()
        }, onError: {[unowned self] (error) in
            self.page -= 1
            self.tableView.mj_footer.endRefreshing()
        }).disposed(by: disposebag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        configUI()
        NotificationCenter.default.rx.notification(Notification.Name.UIKeyboardWillShow).subscribe(onNext: {[unowned self] (notify) in
            let kbValue = notify.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            let kbheight = kbValue.cgRectValue.height
            var tframe = self.tableView.frame
            tframe.size.height = self.view.frame.height - kbheight
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.frame = tframe
                if let index = self.selectIndex {
                    self.tableView.scrollToRow(at: index, at: .top, animated: false)
                }
            })
        }).disposed(by: disposebag)
        NotificationCenter.default.rx.notification(Notification.Name.UIKeyboardWillHide).subscribe(onNext: {[unowned self] (value) in
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.frame = self.view.frame
            })
        }).disposed(by: disposebag)
    }
    
    private func createUI() {
        if isEdit {
            setNavTitle(title: type.rawValue, action: nil).attachIconHiden = true
        } else {
            setNavTitle(title: "去哪吃", action: nil).attachIconHiden = true
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        if isEdit {
            let footer = ZHAddNewItemView.createView()
            footer.addAddEvent { [unowned self] in
                let indexpath: IndexPath?
                switch self.type {
                case .diningroom:
                    let room = ZHDiningRoom()
                    self.diningrooms.append(room)
                    indexpath = IndexPath(row: self.diningrooms.count-1, section: 0)
                case .food:
                    let food = ZHFood()
                    self.foods.append(food)
                    indexpath = IndexPath(row: self.foods.count-1, section: 0)
                }
                self.selectIndex = indexpath!
                self.tableView.insertRows(at: [indexpath!], with: .fade)
                self.tableView.scrollToRow(at: indexpath!, at: .top, animated: true)
            }
            footer.frame = CGRect(x: 0, y: 0, width: ZHScreenWidth, height: 80)
            tableView.tableFooterView = footer
            footerView = footer
        } else {
            tableView.tableFooterView = UIView()
        }
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        doneBtn = addNavRightBtn(title: "完成", image: nil) {[unowned self] in
            if self.isEdit {
                switch self.type {
                case .diningroom:
                    ZHDataStore.share.deleteAllDiningRooms()
                    ZHDataStore.share.insertDiningRooms(diningrooms: self.diningrooms)
                case .food:
                    ZHDataStore.share.deleteAllFoods()
                    ZHDataStore.share.insertFoods(foods: self.foods)
                }
                
            } else {
                ZHDataStore.share.insertDiningRooms(diningrooms: self.selectedrooms)
            }
            self.dismiss(animated: true, completion: nil)
        }
        doneBtn?.isHidden = true
    }
    
    private func configUI() {
        if isEdit {
            tableView.mj_footer.isHidden = true
            doneBtn?.isHidden = false
            switch type {
            case .diningroom:
                self.diningrooms = ZHDataStore.share.searchAllDiningRooms()
            case .food:
                self.foods = ZHDataStore.share.searchAllFoods()
            }
            self.tableView.reloadData()
        } else {
            let hud = ZHProgressHUD.show(in: view, title: "正在检索周边餐厅...")
            tableView.mj_footer.isHidden = diningrooms.count < 20
            ZHLocationHelper.share.searchAround().subscribe(onNext: { [unowned self] (diningrooms) in
                self.diningrooms = diningrooms
                hud.success(title: "检索成功"){
                    
                    self.tableView.mj_footer.isHidden = diningrooms.count < 20
                    self.tableView.reloadData()
                    self.doneBtn?.isHidden = false
                    self.doneBtn?.isEnabled = false
                }
                
            }, onError: { [unowned self] error in
                hud.error(title: "检索失败，请检查网络"){
                    self.dismiss(animated: true)
                }
            }).disposed(by: disposebag)
        }
    }
    
}

extension ZHDataListController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZHShowItemCell.cell(for: tableView, isEdit: isEdit)
        cell.accessoryType = .none
        cell.addDeleteEvent { [unowned self] (cell) in
            let indexpath = tableView.indexPath(for: cell)
            if let index = indexpath {
                switch self.type {
                case .diningroom:
                    self.diningrooms.remove(at: index.row)
                case .food:
                    self.foods.remove(at: index.row)
                }
                tableView.deleteRows(at: [index], with: .fade)
                self.doneBtn?.isEnabled = self.endEdit
                self.footerView?.disable = false;
            }
        }
        cell.addEditEvent { [unowned self] (editEnd, cell, text) in
            self.doneBtn?.isEnabled = editEnd
            let indexpath = tableView.indexPath(for: cell)
            self.endEdit = editEnd
            guard editEnd else {
                self.selectIndex = indexpath
                if cell.title == nil {
                    self.footerView?.disable = true;
                }
                return
            }
            self.footerView?.disable = false;
            guard indexpath != nil else {
                return
            }
            guard !text.isEmpty else {
                switch self.type {
                case .diningroom:
                    self.diningrooms.remove(at: indexpath!.row)
                case .food:
                    self.foods.remove(at: indexpath!.row)
                }
                tableView.deleteRows(at: [indexpath!], with: .fade)
                return
            }
            switch self.type {
            case .diningroom:
                self.diningrooms[indexpath!.row].name = text
            case .food:
                self.foods[indexpath!.row].name = text
            }
        }
        
        cell.addTextInputEvent { [unowned self] (cell, text) in
            let indexpath = tableView.indexPath(for: cell)
            if let index = indexpath {
                switch self.type {
                case .diningroom:
                    self.diningrooms[index.row].name = text
                case .food:
                    self.foods[index.row].name = text
                }
                self.footerView?.disable = text.isEmpty;
            }
        }
        
        let title: String?
        switch type {
        case .diningroom:
            title = diningrooms[indexPath.row].name
            if diningrooms[indexPath.row].isSelected {
                cell.accessoryType = .checkmark
            }
        case .food:
            title = foods[indexPath.row].name
        }
        if title == nil {
            DispatchQueue.main.async {
                cell.becomeActive()
            }
        }
        cell.title = title
        cell.canEdit = isEdit
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        switch type {
        case .diningroom:
            count = self.diningrooms.count
        case .food:
            count = self.foods.count
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isEdit else {
            return
        }
        let room = diningrooms[indexPath.row]
        room.isSelected = !room.isSelected
        if room.isSelected {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        selectedrooms = diningrooms.filter{$0.isSelected}
        doneBtn?.isEnabled = selectedrooms.count > 0
        if selectedrooms.count > 10 {
            room.isSelected = false
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            ZHAlertView.show(title: "最多只能选10项")
        }
    }
}
