//
//  ZHDinningRoomView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift
import SDWebImage

class ZHDiningRoomView: UIView {
    
    @discardableResult
    class func show(with diningroom: ZHDiningRoom) -> ZHDiningRoomView {
        let diningRoom = Bundle.main.loadNibNamed("ZHDiningRoomView", owner: nil, options: nil)
        let diningRoomView = diningRoom?.first as! ZHDiningRoomView
        let rootView = UIApplication.shared.keyWindow
        rootView?.addSubview(diningRoomView)
        diningRoomView.snp.makeConstraints { (make) in
            make.left.top.width.height.equalToSuperview()
        }
        diningRoomView.configView(with: diningroom)
        return diningRoomView
    }
    
    @IBOutlet weak private var roomImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var ratingIcon: UIImageView!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var costLabel: UILabel!
    @IBOutlet weak private var distanceLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    
    
    func configView(with model: ZHDiningRoom) {
        if let imageUrl = model.image {
            roomImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "img-default"))
        }
        titleLabel.text = model.name
        ratingIcon.image = UIImage(named: "icon_star-\(Int(model.rating))")
        ratingLabel.text = "评分\(model.rating)"
        costLabel.text = "￥\(model.cost)"
        distanceLabel.text = "\(model.distance)m"
        addressLabel.text = model.address
    }
    
    @IBAction private func cancelBtnClcicked(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
}
