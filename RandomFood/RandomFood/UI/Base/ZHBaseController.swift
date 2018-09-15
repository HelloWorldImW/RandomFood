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

    private var navType:ZHNavSelectedType?

    let disposebag = DisposeBag()
    var typeSubject = PublishSubject<ZHNavSelectedType>()
    
    lazy var navSelectTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ZHScreenWidth, height: ZHScreenHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        let bgImageView = UIImageView(image: #imageLiteral(resourceName: "navSelectBg"))
        bgImageView.contentMode = .bottom
        tableView.backgroundView = bgImageView
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableViewClicked(_:)))
        tap.delegate = self
        tableView.addGestureRecognizer(tap)
        return tableView
    }()
    
    lazy var randoms:Array<String> = {
        return ["去哪吃","吃什么"]
    }()
    
    lazy var randomsResource:Dictionary<String,String> = {
        return ["去哪吃":"nav_location","吃什么":"nav_food"]
    }()
    
    private var titleView: ZHNavTitleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func showNavSelectView(show: Bool) {
        self.titleView?.attachIconHiden = show
        if show {
            view.addSubview(navSelectTableView)
            self.navSelectTableView.snp.makeConstraints { (make) in
                make.left.top.width.height.equalToSuperview()
            }
            navSelectTableView.reloadData()
        } else {
            navSelectTableView.removeFromSuperview()
        }
    }
    
    @discardableResult
    func setNavTitle(title: String, action:((ZHNavTitleView, Bool)->Void)?) -> ZHNavTitleView {
        
        let titleView = ZHNavTitleView.createView()
        titleView.title = title
        titleView.event.subscribe(onNext: { isSelected in
            if let action = action {
                action(titleView, isSelected)
            }
        }).disposed(by: disposebag)
        
        navigationItem.titleView = titleView
        if titleView.superview != nil {
            titleView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(100)
                make.height.equalTo(44)
            }
        }
        self.titleView = titleView
        return titleView
    }
    @discardableResult
    func addNavRightBtn(title: String?, image: UIImage?, action: @escaping ()->Void) -> UIButton {
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rightBtn.setImage(image, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightBtn.setTitle(title, for: .normal)
        rightBtn.setTitleColor(UIColor(red: 0.0, green: 122/255.0, blue: 1.0, alpha: 1.0), for: .normal)
        rightBtn.setTitleColor(UIColor.gray, for: .disabled)
        rightBtn.rx.tap.asObservable().subscribe(onNext: {
            action()
        }).disposed(by: disposebag)
        let rightItem = UIBarButtonItem(customView: rightBtn)
        navigationItem.rightBarButtonItem = rightItem
        return rightBtn
    }
    @objc func tableViewClicked(_ tap: UITapGestureRecognizer) {
        showNavSelectView(show: false)
    }
    
}

extension ZHBaseController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "randomSelected")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "randomSelected")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.selectionStyle = .none
            cell?.accessoryType = .detailButton
            cell?.backgroundColor = UIColor.clear
        }
        if let cell = cell {
            let title = randoms[indexPath.row]
            var imageName = randomsResource[title]!
            if title == titleView?.title {
                cell.textLabel?.textColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
                imageName = imageName+"_selected"
            } else {
                cell.textLabel?.textColor = UIColor.black
            }
            cell.textLabel?.text = title
            cell.imageView?.image = UIImage(named: imageName)
           
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randoms.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = randoms[indexPath.row]
        self.titleView?.title = title
        UserDefaults.standard.set(title, forKey: ZHRandomTitleKey)
        showNavSelectView(show: false)
        let type = ZHNavSelectedType(rawValue: indexPath.row)!
        if type != self.navType {
            self.navType = type
            typeSubject.onNext(type)
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let type: ZHNavSelectedType = ZHNavSelectedType(rawValue: indexPath.row)!
        var editType: ZHRandomFoodType?
        switch type {
        case .diningroom:
            editType = ZHRandomFoodType.diningroom
        case .food:
            editType = ZHRandomFoodType.food
        }
        DispatchQueue.main.async {
            let diningroom = ZHDataListController()
            diningroom.isEdit = true
            diningroom.type = editType!
            let nav = UINavigationController(rootViewController: diningroom)
            self.present(nav, animated: true) {
                self.showNavSelectView(show: false)
            }
        }
    }
}

extension ZHBaseController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let view = touch.view,
            let superview = view.superview,
            superview.isKind(of: UITableViewCell.self) {
            return false
        }
        return true
    }
}
