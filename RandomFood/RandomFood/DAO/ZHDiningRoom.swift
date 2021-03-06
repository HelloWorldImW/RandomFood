//
//  ZHDiningRoom.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/1.
//  Copyright © 2018年 Darren. All rights reserved.
//

import WCDBSwift

class ZHDiningRoom: WCDBSwift.TableCodable {
    
    var name: String? //!< 店名
    var address: String? //!< 地址
    var tel: String? //!< 联系电话
    var distance: Int = 0 //!< 距离
    var image: String? //!< 图片
    var rating: Float = 0.0 //!< 评分
    var cost: Float = 0.0 //!< 人均消费
    
    var isSelected = false //!<是否被选中，不入库
    var canEdit = false //!< 是否可被编辑
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ZHDiningRoom
        
        case name
        case address
        case tel
        case distance
        case image
        case rating
        case cost
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
    }
    
}

// MARK: - 初始化方法
extension ZHDiningRoom {
    
    convenience init(poi: AMapPOI) {
        self.init()
        self.name = poi.name
        self.address = poi.address
        self.tel = poi.tel
        self.distance = poi.distance
        self.image = poi.images.first?.url
        self.rating = Float(poi.extensionInfo.rating)
        self.cost = Float(poi.extensionInfo.cost)
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
}
