//
//  ZHNavTitleView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/7.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHNavTitleView: UIView {

    class func createView() -> ZHNavTitleView {
        let titleBundle = Bundle.main.loadNibNamed("ZHNavTitleView", owner: nil, options: nil)
        let titleView = titleBundle?.first as! ZHNavTitleView
        return titleView
    }

}
