//
//  ZHRandomFoodController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/30.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHRandomFoodController: ZHBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: "吃什么", action: nil).attachIconHiden = true
        addNavRightBtn(title: "取消", image: nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
