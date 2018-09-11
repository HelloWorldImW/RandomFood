//
//  ZHAddNewItemView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/11.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHAddNewItemView: UIView {
    
    private var addEvent: (()->Void)?
    
    class func createView() -> ZHAddNewItemView {
        let addItemBundle = Bundle.main.loadNibNamed("ZHAddNewItemView", owner: nil, options: nil)
        let addItemView = addItemBundle?.first as! ZHAddNewItemView
        return addItemView
    }
    
    func addAddEvent(event: (()->Void)?) {
        addEvent = event
    }
    
    @IBAction private func addNewItemClicked(_ sender: UITapGestureRecognizer) {
        if let event = addEvent {
            event()
        }
    }
    
}
