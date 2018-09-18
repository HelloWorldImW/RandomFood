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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
