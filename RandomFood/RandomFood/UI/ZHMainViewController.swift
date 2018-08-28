//
//  ZHMainViewController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/28.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHMainViewController: UIViewController {
    
    enum ZHError: Error {
        case somethinerror
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let va = Variable("sdsa")
        _ = va.asObservable().subscribe(onNext: { str in
            self.printas()
        }){
            print("释放")
        }
        va.value = "dsa"
        
    }
    
    func printas() {
        print("dsadasdasd")
    }

}
