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
        addBackgroundImg(image: #imageLiteral(resourceName: "BackgroundBlur"))
    }
    
    func addBackgroundImg(image: UIImage) {
        view.layer.contents = image.cgImage
        view.layer.backgroundColor = UIColor.clear.cgColor
    }
    
}

