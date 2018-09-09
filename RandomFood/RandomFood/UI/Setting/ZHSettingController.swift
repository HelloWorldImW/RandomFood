//
//  ZHSettingController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/8.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHSettingController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: view.frame, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        table.rowHeight = 70
        return table
    }()
    
    let settingDatas = ["打赏作者", "评分", "关于作品"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        navigationController?.navigationBar.topItem?.title = ""
    }

}

extension ZHSettingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZHShowItemCell.cell(for: tableView)
        cell.title = settingDatas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingDatas.count
    }
    
}
