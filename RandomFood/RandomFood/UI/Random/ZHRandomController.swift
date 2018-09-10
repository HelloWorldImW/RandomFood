//
//  ZHRandomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/1.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

enum ZHRandomType {
    case food
    case diningroom
}

class ZHRandomController: ZHBaseController {
    
    private let sharkImageView = UIImageView(image: #imageLiteral(resourceName: "shark_0"))
    private let sharkTitleImageView = UIImageView(image: #imageLiteral(resourceName: "shart_title"))
    private var type: ZHRandomType?
    
    var diningrooms: Array<ZHDiningRoom>?
    
    convenience init(type randomType: ZHRandomType) {
        self.init()
        self.type = randomType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var title: String? = UserDefaults.standard.value(forKey: ZHRandomTitleKey) as? String
        if title == nil {
            title = "吃什么"
        }
        setNavTitle(title: title!) { titleView, isSelected in
            self.showNavSelectView(show: isSelected)
            titleView.attachIconHiden = isSelected
        }
        createUI()
        diningrooms = ZHDataStore.share.searchAllDiningRooms()
    }
    
    private func random<T>(for items: Array<T>) -> T {
        let random = arc4random_uniform(UInt32(items.count))
        let item = items[Int(random)]
        return item
    }
    
}

///获取数据
extension ZHRandomController {
    
}

/// 摇一摇
extension ZHRandomController {
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        sharkImageView.startAnimating()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
       showResult()
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        showResult()
    }
    
    private func showResult() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) {
            self.sharkImageView.stopAnimating()
            let room = self.random(for: self.diningrooms!)
            ZHDiningRoomView.show(with: room)
        }
    }
    
}

/// UI相关
extension ZHRandomController {
    private func createUI() {
        sharkImageView.animationImages = [#imageLiteral(resourceName: "shark_0"),#imageLiteral(resourceName: "shark_1")]
        
        view.addSubview(sharkImageView)
        view.addSubview(sharkTitleImageView)
        
        sharkImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.width.equalTo(109)
            make.height.equalTo(96)
        }
        
        sharkTitleImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(80)
            make.width.equalTo(99)
            make.height.equalTo(40)
        }
        sharkImageView.animationDuration = 0.5
    }
}



