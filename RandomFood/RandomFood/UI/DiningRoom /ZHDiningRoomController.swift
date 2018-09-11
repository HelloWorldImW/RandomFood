//
//  ZHDiningRoomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHDiningRoomController: ZHBaseController {
    
    var isEdit = false
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        return table
    }()
    
    var diningrooms:Array<ZHDiningRoom> = []
    
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
    }
    
    private func configUI() {
        if isEdit {
            
        } else {
            let hud = ZHProgressHUD.show(in: view, title: "正在检索周边餐厅...")
            ZHLocationHelper.share.searchAround().subscribe(onNext: { (diningrooms) in
                self.diningrooms = diningrooms
                hud.success(title: "检索成功"){
                    self.addNavRightBtn(title: "取消", image: nil) {
                        self.dismiss(animated: true, completion: nil)
                    }
                    self.tableView.reloadData()
                }
                
            }, onError: { error in
                hud.error(title: "检索失败，请检查网络"){
                    self.dismiss(animated: true)
                }
            }).disposed(by: self.disposebag)
        }
    }
    
}

extension ZHDiningRoomController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "diningroomCell")
        let diningroom = diningrooms[indexPath.row]
        cell.textLabel?.text = diningroom.name
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
        diningrooms[indexPath.row].isSelected = !diningrooms[indexPath.row].isSelected
        if diningrooms[indexPath.row].isSelected {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
}
