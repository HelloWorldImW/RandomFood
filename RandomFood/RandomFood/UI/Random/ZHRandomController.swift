//
//  ZHRandomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/1.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift

class ZHRandomController: ZHBaseController {
    
    private let sharkImageView = UIImageView(image: #imageLiteral(resourceName: "shark_0"))
    private let sharkTitleImageView = UIImageView(image: #imageLiteral(resourceName: "shart_title"))
    private var type: ZHRandomFoodType = .diningroom
    
    private var diningroomView: ZHDiningRoomView? = nil
    private var foodView: ZHFoodView? = nil
    
    var diningrooms: Array<ZHDiningRoom>?
    var foods: Array<ZHFood>?
    
    convenience init(type randomType: ZHRandomFoodType) {
        self.init()
        self.type = randomType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle(title: type.rawValue) { titleView, isSelected in
            self.showNavSelectView(show: isSelected)
        }
        
        typeSubject.asObservable().subscribe(onNext: { (type) in
            switch type {
            case .food:
                self.foods = ZHDataStore.share.searchAllFoods()
            case .diningroom:
                self.diningrooms = ZHDataStore.share.searchAllDiningRooms()
            }
        }).disposed(by: disposebag)
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch type {
        case .diningroom:
            diningrooms = ZHDataStore.share.searchAllDiningRooms()
        case .food:
            foods = ZHDataStore.share.searchAllFoods()
        }
    }
    
    private func random<T>(for items: Array<T>) -> T {
        let random = arc4random_uniform(UInt32(items.count))
        let item = items[Int(random)]
        return item
    }
    
}

/// 摇一摇
extension ZHRandomController {
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        switch type {
        case .diningroom:
            if diningrooms!.isEmpty {
                ZHAlertView.show(title: "本地无数据", message: "是否开启定位获取周围餐厅") {
                    let nav = UINavigationController(rootViewController: ZHDataListController())
                    self.present(nav, animated: true)
                }
            } else {
                if let diningroom = diningroomView {
                    diningroom.hide()
                }
                sharkImageView.startAnimating()
            }
        case .food:
            if let food = foodView {
                food.hide()
            }
            sharkImageView.startAnimating()
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
       showResult()
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        showResult()
    }
    
    private func showResult() {
        switch type {
        case .diningroom:
            guard !diningrooms!.isEmpty else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) {
                self.sharkImageView.stopAnimating()
                let room = self.random(for: self.diningrooms!)
                self.diningroomView = ZHDiningRoomView.show(with: room)
            }
        case .food:
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0) {
                self.sharkImageView.stopAnimating()
                let food = self.random(for: self.foods!)
                self.foodView = ZHFoodView.show(with: food)
            }
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



