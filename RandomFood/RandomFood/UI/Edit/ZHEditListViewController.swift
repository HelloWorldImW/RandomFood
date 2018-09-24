//
//  ZHEditListViewController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/22.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

enum ZHEditListType: String {
    case choice = "选择"
    case edit = "编辑"
    func getContent() -> String {
        switch self {
        case .choice:
            return "CHOICE OF FOOD"
        case .edit:
            return "EDITING FOOD"
        }
    }
}

class ZHEditListViewController: ZHBaseViewController {
    
    private var type = ZHEditListType.edit
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.frame, style: .grouped)
        table.rowHeight = 70
        table.separatorStyle = .none
        return table
    }()
    
    private let listViewModel = ZHEditListViewModel()
    
    convenience init(type: ZHEditListType) {
        self.init()
        self.type = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleView = createTitle(title: self.type.rawValue, content: self.type.getContent())
        createRightBtn(img:#imageLiteral(resourceName: "icon_close"), handel: {[unowned self] in
            self.dismiss(animated: true)
        })
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.content.snp.bottom).offset(ZHScreenHeight*0.075)
            make.left.right.bottom.equalToSuperview()
        }
    }

}
