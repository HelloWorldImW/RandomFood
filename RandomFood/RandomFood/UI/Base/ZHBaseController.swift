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


class ZHBaseController: UIViewController {

    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "hello"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let titleView = ZHNavTitleView.createView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        navigationItem.titleView = titleView
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = UIColor.white
    }
}
