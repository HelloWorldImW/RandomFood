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
import RxGesture
import SnapKit

class ZHBaseViewController: UIViewController {
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
}

// MARK: 界面相关
extension ZHBaseViewController {
    
    func addBackgroundImg(image: UIImage) {
        view.layer.contents = image.cgImage
        view.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    @discardableResult
    func createTitle(title: String, content: String) -> (title: UILabel, content: UILabel) {
        let color = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = color
        titleLabel.adjustsFontSizeToFitWidth = true
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
        return (title: titleLabel, content: contentLabel)
    }
    
    @discardableResult
    func createRightBtn(img: UIImage, handel:(()->Void)?=nil) -> UIImageView {
        let btnImg = UIImageView(image: img)
        btnImg.isUserInteractionEnabled = true
        btnImg.contentMode = .center
        btnImg.rx.tapGesture().subscribe(onNext: { (tap) in
            if let handel = handel {
                handel()
            }
        }).disposed(by: disposebag)
        view.addSubview(btnImg)
        btnImg.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(7)
            make.width.height.equalTo(60)
        }
        return btnImg
    }
}
