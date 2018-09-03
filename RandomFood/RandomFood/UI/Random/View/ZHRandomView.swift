//
//  ZHRandomView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/3.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHRandomView: UIView {

    class func createView() -> ZHRandomView {
        let random = Bundle.main.loadNibNamed("ZHRandomView", owner: nil, options: nil)
        let randomView = random?.first as! ZHRandomView
        return randomView
    }

}
