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
        self.navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = UIColor.white
    }
}
