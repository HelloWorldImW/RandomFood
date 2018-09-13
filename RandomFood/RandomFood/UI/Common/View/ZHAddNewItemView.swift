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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    class func createView() -> ZHAddNewItemView {
        let addItemBundle = Bundle.main.loadNibNamed("ZHAddNewItemView", owner: nil, options: nil)
        let addItemView = addItemBundle?.first as! ZHAddNewItemView
        return addItemView
    }
    
    var disable: Bool = false {
        didSet {
            self.iconImageView.isHighlighted = disable
            if disable {
                self.titleLabel.textColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0)
            } else {
                self.titleLabel.textColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
            }
            self.isUserInteractionEnabled = !disable
        }
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
