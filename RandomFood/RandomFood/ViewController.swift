//
//  ViewController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/25.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import WCDBSwift

class UserInfo: TableCodable {
    var userId: Int? = nil
    var name: String? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = UserInfo
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case userId
        case name
    }
}

class ViewController: UIViewController {
    
    lazy var database: Database = {
        var path = NSHomeDirectory()+"/Documents/randomFood.db"
        return Database(withPath: path)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! database.create(table: "UserInfo", of: UserInfo.self)
        
        let user = UserInfo()
        user.userId = 1
        user.name = "小明"
        try! database.insert(objects: user, intoTable: "UserInfo")
        
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
       
    }
    
    @IBAction func delBtnClicked(_ sender: Any) {
        
    }
    
    @IBAction func modifyBtnClicked(_ sender: Any) {
        
    }
    
    @IBAction func queryBtnClicked(_ sender: Any) {
        let users: [UserInfo] = try! database.getObjects(fromTable: "UserInfo")
        users.forEach { (user) in
            print(user)
        }
    }
    
    
}

