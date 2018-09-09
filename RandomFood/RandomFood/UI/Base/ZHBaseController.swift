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

enum ZHNavSelectedType: Int {
    case diningroom = 0
    case food
}

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
    
    func createNavItem() {
        guard self.navigationController != nil else {
            return
        }
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
        addNavRightBtn(title: nil, image: #imageLiteral(resourceName: "setting")) {
            self.navigationController?.pushViewController(ZHSettingController(), animated: true)
        }
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func addNavRightBtn(title: String?, image: UIImage?, action: @escaping ()->Void) {
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rightBtn.setImage(image, for: .normal)
        rightBtn.setTitle(title, for: .normal)
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        rightBtn.rx.tap.asObservable().subscribe(onNext: {
            action()
        }).disposed(by: disposebag)
        let rightItem = UIBarButtonItem(customView: rightBtn)
        navigationItem.rightBarButtonItem = rightItem
    }
    
}

extension ZHBaseController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "randomSelected")
        let title = randoms[indexPath.row]
        cell.textLabel?.text = title
        cell.imageView?.image = randomsResource[title]
        cell.selectionStyle = .none
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randoms.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type: ZHNavSelectedType = ZHNavSelectedType(rawValue: indexPath.row)!
        switch type {
        case .diningroom:
            print("")
        case .food:
            print("")
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let type: ZHNavSelectedType = ZHNavSelectedType(rawValue: indexPath.row)!
        switch type {
        case .diningroom:
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: ZHDiningRoomController())
                self.present(nav, animated: true, completion: nil)
            }
        case .food:
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: ZHRandomFoodController())
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
}








