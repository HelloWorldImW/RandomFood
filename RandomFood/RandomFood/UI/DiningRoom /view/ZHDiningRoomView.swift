//
//  ZHDinningRoomView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHDiningRoomView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    class func createView() -> ZHDiningRoomView {
        let diningRoom = Bundle.main.loadNibNamed("ZHDiningRoomView", owner: nil, options: nil)
        let diningRoomView = diningRoom?.first as! ZHDiningRoomView
        return diningRoomView
    }
    
    
}
