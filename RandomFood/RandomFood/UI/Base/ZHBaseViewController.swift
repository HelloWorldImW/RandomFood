//
//  ZHBaseViewController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/19.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ZHBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: 界面相关
extension ZHBaseViewController {
    
    func addBackgroundImg(image: UIImage) {
        view.layer.contents = image.cgImage
        view.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func createTitle(title: String, content: String) {
        let color = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = color
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(20)
            make.height.equalTo(50)
            make.width.greaterThanOrEqualTo(200)
        }
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.font = UIFont.systemFont(ofSize: 12)
        contentLabel.textColor = color
        view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
            make.height.equalTo(17)
            make.width.greaterThanOrEqualTo(200)
        }
    }
    
    func createRightBtn(img: UIImage) {
        let btnImg = UIImageView(image: img)
        view.addSubview(btnImg)
        btnImg.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(28)
            make.width.height.equalTo(18)
        }
    }
}
