//
//  ZHFoodView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/4.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHFoodView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @discardableResult
    class func show(with food: ZHFood) -> ZHFoodView {
        let foodBundle = Bundle.main.loadNibNamed("ZHFoodView", owner: nil, options: nil)
        let foodView = foodBundle?.first as! ZHFoodView
        let rootView = UIApplication.shared.keyWindow
        rootView?.addSubview(foodView)
        foodView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        foodView.configView(with: food)
        return foodView
    }
    
    func hide() {
        self.removeFromSuperview()
    }
    
    private func configView(with food: ZHFood) {
        if let image = food.image {
            self.iconImageView.image = UIImage(named: image)            
        }
        self.titleLabel.text = food.name
    }
    
    @IBAction func cancaleBtnClicked(_ sender: Any) {
        self.removeFromSuperview()
    }
}
