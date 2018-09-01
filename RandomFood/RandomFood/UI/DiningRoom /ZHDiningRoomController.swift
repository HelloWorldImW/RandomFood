//
//  ZHDiningRoomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class ZHDiningRoomController: UIViewController {
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ZHLocationHelper.share.searchAround().subscribe(onNext: { (diningroom) in
            print(diningroom)
        }).disposed(by: disposebag)
    }
}
