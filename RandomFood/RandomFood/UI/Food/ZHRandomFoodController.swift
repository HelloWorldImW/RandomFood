//
//  ZHRandomFoodController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/30.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHRandomFoodController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ZHLocationHelper.share.searchAround().subscribe(onNext: { names in
//            print(names)
//        }, onError: { error in
//            print(error)
//        }).disposed(by: disposeBag)
    }

}
