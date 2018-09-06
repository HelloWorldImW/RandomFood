//
//  ZHBaseController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/5.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHBaseController: UIViewController {

    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "hello"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let titleBtn = UIButton(type: .custom)
        titleBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleBtn.setTitle("测试", for: .normal)
        titleBtn.setTitleColor(UIColor.black, for: .normal)
        navigationItem.titleView = titleBtn
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = UIColor.white
    }
}
