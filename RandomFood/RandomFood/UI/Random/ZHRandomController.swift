//
//  ZHRandomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/1.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHRandomController: ZHBaseController {
    
    let sharkImageView = UIImageView(image: #imageLiteral(resourceName: "shark_0"))
    let sharkTitleImageView = UIImageView(image: #imageLiteral(resourceName: "shart_title"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharkImageView.animationImages = [#imageLiteral(resourceName: "shark_0"),#imageLiteral(resourceName: "shark_1")]
        
        view.addSubview(sharkImageView)
        view.addSubview(sharkTitleImageView)
        
        sharkImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.width.equalTo(109)
            make.height.equalTo(96)
        }
        
        sharkTitleImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(80)
            make.width.equalTo(99)
            make.height.equalTo(40)
        }
        sharkImageView.animationDuration = 0.5
        
    }
    
}
