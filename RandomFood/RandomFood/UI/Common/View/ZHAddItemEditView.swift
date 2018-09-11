//
//  ZHAddItemEditView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/11.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHAddItemEditView: UIView {

    @IBOutlet weak private var textField: UITextField!
    
    private var addEvent: ((String)->Void)?
    
    @discardableResult
    class func show() -> ZHAddItemEditView {
        let addBundle = Bundle.main.loadNibNamed("ZHAddItemEditView", owner: nil, options: nil)
        let addView = addBundle?.first as! ZHAddItemEditView
        let rootView = UIApplication.shared.keyWindow
        rootView?.addSubview(addView)
        addView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        return addView
    }
    
    func setAddEvent(event: ((String)->Void)?) {
        addEvent = event
    }
    
    @IBAction func okBtnClicked(_ sender: Any) {
        if let event = addEvent {
            if (textField.text?.isEmpty)! {
                ZHAlertView.show(title: "内容不能为空")
            } else {
                event(textField.text!)
                removeFromSuperview()
            }
        }
    }
    
}
