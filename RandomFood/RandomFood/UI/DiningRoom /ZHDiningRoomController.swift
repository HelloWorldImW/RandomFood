//
//  ZHDiningRoomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class ZHDiningRoomController: ZHBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "去哪吃"
        addNavRightBtn(title: "取消", image: nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
