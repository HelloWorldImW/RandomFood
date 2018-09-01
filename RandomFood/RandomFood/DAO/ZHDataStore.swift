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
    private let DiningRoomTable = "DiningRoomTable"
    
}

/// 创建数据表
extension ZHDataStore {
    
    /// 创建食物表
    func createFoodTable() {
        do {
            try db.create(table: FoodTable, of: ZHFood.self)
        } catch  {
            print("创建数据表Food失败")
        }
    }
    
    /// 创建餐馆表
    func createRestaurantTable() {
        do {
            try db.create(table: DiningRoomTable, of: ZHDiningRoom.self)
        } catch  {
            print("创建数据表Restaurant失败")
        }
    }
}
