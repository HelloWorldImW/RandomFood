//
//  ZHAlertView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/9.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHAlertView: UIAlertView {
    
    private var okcallback:(()->Void)?
    
    class func show(title: String, message: String, okBlock: (()->Void)?) {
        let alert = ZHAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.delegate = alert
        alert.okcallback = okBlock
        alert.show()
    }
}

extension ZHAlertView: UIAlertViewDelegate {
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        let title = alertView.buttonTitle(at: buttonIndex)
        if title == "确定" {
            if let okcallback = okcallback {
                okcallback()
            }
        }
    }
}
