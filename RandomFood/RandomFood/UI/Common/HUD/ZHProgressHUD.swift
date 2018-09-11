//
//  ZHProgressHUD.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/11.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHProgressHUD: UIView {
    
    @discardableResult
    class func show(title: String?) -> ZHProgressHUD {
        let progressBundle = Bundle.main.loadNibNamed("ZHProgressHUD", owner: nil, options: nil)
        let progressHUD = progressBundle?.first as! ZHProgressHUD
        let rootView = UIApplication.shared.keyWindow
        rootView?.addSubview(progressHUD)
        progressHUD.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        progressHUD.animationImageView.animationImages = [#imageLiteral(resourceName: "animation_location0"),#imageLiteral(resourceName: "animation_location1")]
        progressHUD.animationImageView.animationDuration = 0.8
        progressHUD.animationImageView.startAnimating()
        progressHUD.titleLabel.text = title
        return progressHUD
    }
    
    func hiden() {
        self.animationImageView.stopAnimating()
        self.removeFromSuperview()
    }
    
    func error(title: String?, duration: Double = 1.0) {
        self.animationImageView.stopAnimating()
        self.animationImageView.image = #imageLiteral(resourceName: "error")
        self.titleLabel.text = title
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: duration)) {
            self.removeFromSuperview()
        }
    }
    
    func success(title: String?, duration: Double = 1.0) {
        self.animationImageView.stopAnimating()
        self.animationImageView.image = #imageLiteral(resourceName: "success")
        self.titleLabel.text = title
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: duration)) {
            self.removeFromSuperview()
        }
    }
    
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}
