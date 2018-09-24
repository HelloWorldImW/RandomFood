//
//  ZHEditListViewModel.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/22.
//  Copyright © 2018年 Darren. All rights reserved.
//

import RxSwift

struct ZHEditListSectionModel {
    var title = ""
    var data: Array<ZHDiningRoom> = []
}


struct ZHEditListViewModel {
    let data = Observable.just([
        ZHEditListSectionModel(title: "第一个Section", data: [
            ZHDiningRoom(name: "1"),
            ZHDiningRoom(name: "2"),
            ZHDiningRoom(name: "3"),
            ZHDiningRoom(name: "4")
            ]),
        ZHEditListSectionModel(title: "第二个Section", data: [
            ZHDiningRoom(name: "1"),
            ZHDiningRoom(name: "2"),
            ZHDiningRoom(name: "3"),
            ZHDiningRoom(name: "4")
            ])
        ])
}
