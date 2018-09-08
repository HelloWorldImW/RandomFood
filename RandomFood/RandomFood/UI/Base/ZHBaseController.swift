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
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNav()
    }
    
    private func showNavSelectView() {
        view.addSubview(navSelectTableView)
        self.navSelectTableView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
    }
    
    
    private func createNav() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let titleView = ZHNavTitleView.createView()
        
        titleView.event.subscribe(onNext: {[weak self] in
            self?.showNavSelectView()
        }).disposed(by: disposebag)
        
        navigationItem.titleView = titleView
        titleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        let rbtn = UIButton(type: .custom)
        rbtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rbtn.setImage(#imageLiteral(resourceName: "setting"), for: .normal)
        rbtn.setTitleColor(UIColor.black, for: .normal)
        let ritem = UIBarButtonItem(customView: rbtn)
        navigationItem.rightBarButtonItem = ritem
        
        let lbtn = UIButton(type: .custom)
        lbtn.frame = CGRect(x: 0, y: 0, width: 21, height: 7)
        lbtn.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        lbtn.setTitleColor(UIColor.black, for: .normal)
        let litem = UIBarButtonItem(customView: lbtn)
        navigationItem.leftBarButtonItem = litem
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = UIColor.white
    }
}

extension ZHBaseController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "adadsds")
        cell.textLabel?.text = "Test"
        cell.imageView?.image = #imageLiteral(resourceName: "nav_food")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
}








