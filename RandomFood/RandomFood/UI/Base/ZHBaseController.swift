//
//  ZHBaseController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/5.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ZHBaseController: UIViewController {

    let disposebag = DisposeBag()
    
    lazy var navSelectTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ZHScreenWidth, height: ZHScreenHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 1.0, alpha: 0.99)
        return tableView
    }()
    
    lazy var randoms:Array<String> = {
        return ["去哪吃","吃什么"]
    }()
    
    lazy var randomsResource:Dictionary<String,UIImage> = {
        return ["去哪吃":#imageLiteral(resourceName: "nav_location"),"吃什么":#imageLiteral(resourceName: "nav_food")]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        createNavItem()
    }
    
    private func showNavSelectView(show: Bool) {
        if show {
            view.addSubview(navSelectTableView)
            self.navSelectTableView.snp.makeConstraints { (make) in
                make.left.top.width.height.equalToSuperview()
            }
        } else {
            navSelectTableView.removeFromSuperview()
        }
    }
    
    private func createNavItem() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let titleView = ZHNavTitleView.createView()
        
        titleView.event.subscribe(onNext: { isSelected in
            self.showNavSelectView(show: isSelected)
        }).disposed(by: disposebag)
        
        navigationItem.titleView = titleView
        titleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        let settingBtn = UIButton(type: .custom)
        settingBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        settingBtn.setImage(#imageLiteral(resourceName: "setting"), for: .normal)
        settingBtn.rx.tap.asObservable().subscribe(onNext: {
            self.navigationController?.pushViewController(ZHSettingController(), animated: true)
        }).disposed(by: disposebag)
        let settingItem = UIBarButtonItem(customView: settingBtn)
        navigationItem.rightBarButtonItem = settingItem
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension ZHBaseController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "randomSelected")
        let title = randoms[indexPath.row]
        cell.textLabel?.text = title
        cell.imageView?.image = randomsResource[title]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randoms.count
    }
}








