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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleAttachIcon: UIImageView!
    
    private let eventSubject = PublishSubject<Void>()
    
    var event: Observable<Void> {
        return eventSubject.asObservable()
    }
    
    class func createView() -> ZHNavTitleView {
        let titleBundle = Bundle.main.loadNibNamed("ZHNavTitleView", owner: nil, options: nil)
        let titleView = titleBundle?.first as! ZHNavTitleView
        return titleView
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        eventSubject.onCompleted()
    }
    
    @IBAction func titleViewClicked(_ sender: UITapGestureRecognizer) {
        eventSubject.onNext(())
    }
    
}
