//
//  ZHDiningRoomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import SnapKit

class ZHDiningRoomController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = ZHDiningRoomView.createView()
        view.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
}
