//
//  ZHDataStore.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/26.
//  Copyright © 2018年 Darren. All rights reserved.
//

import WCDBSwift

// MARK: 数据库对象
class ZHDataStore: NSObject {
    
    static let share = ZHDataStore()
    
    lazy var db: Database = {
        let path = NSHomeDirectory() + "/Documents/randomFood.db"
        return Database(withPath: path)
    }()
    
    private override init() {
        super.init()
        createFoodTable()
        createRestaurantTable()
    }
    
    
    /// 食物表
    private let FoodTable = "FoodTable"
    /// 餐馆表
    private let RestaurantTable = "RestaurantTable"
    
}

/// 创建数据表
extension ZHDataStore {
    
    /// 创建食物表
    func createFoodTable() {
        do {
            try db.create(table: FoodTable, of: Food.self)
        } catch  {
            print("创建数据表Food失败")
        }
    }
    
    /// 创建餐馆表
    func createRestaurantTable() {
        do {
            try db.create(table: RestaurantTable, of: Restaurant.self)
        } catch  {
            print("创建数据表Restaurant失败")
        }
    }
}

// MARK:数据表对象
/// 食物表
class Food: WCDBSwift.TableCodable {
    
    var name: String?
    var eatTime: Int?
    
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Food
        
        case name
        case eatTime
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
    }
}

/// 餐馆表
class Restaurant: WCDBSwift.TableCodable {
    
    var name: String?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Restaurant
        
        case name
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
    }
}

