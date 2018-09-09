//
//  ZHNavTitleView.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/7.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHNavTitleView: UIView {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var titleAttachIcon: UIImageView!
    private var isSelected = false
    
    private let eventSubject = PublishSubject<Bool>()
    
    var event: Observable<Bool> {
        return eventSubject.asObservable()
    }
    
    class func createView() -> ZHNavTitleView {
        let titleBundle = Bundle.main.loadNibNamed("ZHNavTitleView", owner: nil, options: nil)
        let titleView = titleBundle?.first as! ZHNavTitleView
        return titleView
    }
        
    @IBAction func titleViewClicked(_ sender: UITapGestureRecognizer) {
        isSelected = !isSelected
        eventSubject.onNext(isSelected)
    }
    
}
