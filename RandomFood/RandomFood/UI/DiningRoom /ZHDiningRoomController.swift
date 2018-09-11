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
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 80.0
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        table.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        return table
    }()
    
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        
        doneBtn = addNavRightBtn(title: "完成", image: nil) {
            ZHDataStore.share.insertDiningRooms(diningrooms: self.selectedrooms)
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
            }
        }
        cell.title = diningroom.name
        if diningroom.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = ZHAddNewItemView.createView()
        footer.addAddEvent {
            ZHAddItemEditView.show().setAddEvent(event: { (title) in
                let room = ZHDiningRoom()
                room.name = title
                self.diningrooms.append(room)
                let indexPath = IndexPath(row: self.diningrooms.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: .fade)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            })
            
        }
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80.0
    }
}
