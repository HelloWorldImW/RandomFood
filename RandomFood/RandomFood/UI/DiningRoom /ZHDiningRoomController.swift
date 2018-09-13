//
//  ZHDiningRoomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import MJRefresh

class ZHDiningRoomController: ZHBaseController {
    
    var isEdit = false
    
    private var page = 1
    
    private var doneBtn: UIButton?
    
    let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: ZHScreenWidth, height: ZHScreenHeight), style: .plain)
    
    var diningrooms:Array<ZHDiningRoom> = []
    var selectedrooms:Array<ZHDiningRoom> = []
    
    @objc func loadMoreData() {
        self.page += 1
        ZHLocationHelper.share.searchAround(page: self.page).subscribe(onNext: { [weak self] (rooms) in
            self?.diningrooms.append(contentsOf: rooms)
            if rooms.count < 20 {
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.mj_footer.endRefreshing()
            }
            self?.tableView.reloadData()
        }, onError: {[weak self] (error) in
            self?.page -= 1
            self?.tableView.mj_footer.endRefreshing()
        }).disposed(by: disposebag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        configUI()
    }
    
    private func createUI() {
        setNavTitle(title: "去哪吃", action: nil).attachIconHiden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        if isEdit {
            let footer = ZHAddNewItemView.createView()
            footer.addAddEvent {
                let room = ZHDiningRoom()
                self.diningrooms.append(room)
                let indexPath = IndexPath(row: self.diningrooms.count-1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .fade)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            footer.frame = CGRect(x: 0, y: 0, width: ZHScreenWidth, height: 80)
            tableView.tableFooterView = footer
        } else {
            tableView.tableFooterView = UIView()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        
        doneBtn = addNavRightBtn(title: "完成", image: nil) {
            if self.isEdit {
                ZHDataStore.share.deleteAllDiningRooms()
                ZHDataStore.share.insertDiningRooms(diningrooms: self.diningrooms)
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
            self.diningrooms = ZHDataStore.share.searchAllDiningRooms()
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

extension ZHDiningRoomController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZHShowItemCell.cell(for: tableView, isEdit: isEdit)
        let diningroom = diningrooms[indexPath.row]
        cell.addDeleteEvent { (indexpath) in
            if let index = indexpath {
                self.diningrooms.remove(at: index.row)
                tableView.deleteRows(at: [index], with: .fade)
                self.doneBtn?.isEnabled = true
            }
        }
        cell.addEditEvent { (editEnd,indexpath, text) in
            self.doneBtn?.isEnabled = editEnd
            guard editEnd else {
                return
            }
            guard !indexPath.isEmpty else {
                return
            }
            guard !text.isEmpty else {
                self.diningrooms.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                return
            }
            let room = self.diningrooms[indexPath.row]
            room.name = text
            
        }
        if diningroom.name == nil {
            DispatchQueue.main.async {
                cell.becomeActive()
            }
        }
        cell.title = diningroom.name
        if diningroom.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.canEdit = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diningrooms.count
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
