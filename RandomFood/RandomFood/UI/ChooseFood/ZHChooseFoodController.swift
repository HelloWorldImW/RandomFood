//
//  ZHChooseFoodController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/26.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHChooseFoodController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.applicationSupportsShakeToEdit = true
        becomeFirstResponder()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("晃动开始")
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("晃动结束")
    }
 
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("晃动取消")
    }
}
