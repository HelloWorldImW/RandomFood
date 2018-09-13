//
//  ZHFood.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/1.
//  Copyright © 2018年 Darren. All rights reserved.
//

import WCDBSwift

class ZHFood: WCDBSwift.TableCodable {
    
    var name: String?
    /// 0:早餐   1：午餐  2：晚餐  3：宵夜
    var eatTime: Int?
    var image: String?
    
    var canEdit = false //!< 是否可被编辑
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ZHFood
        
        case name
        case eatTime
        case image
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
    }
}
