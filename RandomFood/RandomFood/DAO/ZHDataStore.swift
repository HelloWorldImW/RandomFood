//
//  ZHDataStore.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/26.
//  Copyright © 2018年 Darren. All rights reserved.
//

import WCDBSwift
import RxSwift

// MARK: 数据库对象
class ZHDataStore: NSObject {
    
    static let share = ZHDataStore()
    
    lazy var db: Database = {
        let path = NSHomeDirectory() + "/Documents/randomFood.db"
        return Database(withPath: path)
    }()
    
    private override init() {
        super.init()
        createRestaurantTable()
    }
    
    /// 餐厅表
    private let DiningRoomTable = "DiningRoomTable"
    
}

/// 创建数据表
extension ZHDataStore {
    /// 创建餐厅表
    func createRestaurantTable() {
        do {
            try db.create(table: DiningRoomTable, of: ZHDiningRoom.self)
        } catch  {
            print("创建数据表Restaurant失败")
        }
    }
}

// MARK: - 数据库操作 - DiningRoom
extension ZHDataStore {
    
    func insertDiningRoom(diningroom: ZHDiningRoom) {
        try! db.insert(objects: diningroom, intoTable: DiningRoomTable)
    }
    
    func insertDiningRooms(diningrooms: [ZHDiningRoom]) {
        try! db.insert(objects: diningrooms, intoTable: DiningRoomTable)
    }
    
    func deleteDiningRoom(diningroom: ZHDiningRoom) {
        try! db.delete(fromTable: DiningRoomTable, where: ZHDiningRoom.Properties.name.is(diningroom.name!))
    }
    
    func deleteAllDiningRooms() {
        try! db.delete(fromTable: DiningRoomTable)
    }
    
    func searchAllDiningRooms() -> [ZHDiningRoom] {
        let diningrooms: [ZHDiningRoom] = try! db.getObjects(fromTable: DiningRoomTable)
        return diningrooms
    }
}
