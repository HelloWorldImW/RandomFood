//
//  ZHProgressHUD.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/11.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import SDWebImage

class ZHProgressHUD: UIView {
    
    @discardableResult
    class func show(in superView: UIView, title: String?) -> ZHProgressHUD {
        let progressBundle = Bundle.main.loadNibNamed("ZHProgressHUD", owner: nil, options: nil)
        let progressHUD = progressBundle?.first as! ZHProgressHUD
        superView.addSubview(progressHUD)
        progressHUD.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        let path = Bundle.main.path(forResource: "animation_location.gif", ofType: "")
        let imgData = NSData(contentsOfFile: path!)!
        progressHUD.animationImageView.image = UIImage.sd_animatedGIF(with: imgData as Data?)
        progressHUD.titleLabel.text = title
        return progressHUD
    }
    
    func hiden() {
        self.animationImageView.stopAnimating()
        self.removeFromSuperview()
    }
    
    func error(title: String?, duration: Double = 1.0, completed: (()->Void)?) {
        self.animationImageView.stopAnimating()
        self.animationImageView.image = #imageLiteral(resourceName: "error")
        self.titleLabel.text = title
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: duration)) {
            self.removeFromSuperview()
            if let completed = completed {
                completed()
            }
        }
    }
    
    func success(title: String?, duration: Double = 1.0, completed: (()->Void)?) {
        self.animationImageView.stopAnimating()
        self.animationImageView.image = #imageLiteral(resourceName: "success")
        self.titleLabel.text = title
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: duration)) {
            self.removeFromSuperview()
            if let completed = completed {
                completed()
            }
        }
    }
    
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}
