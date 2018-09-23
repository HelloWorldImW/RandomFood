//
//  ZHEditListViewModel.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/22.
//  Copyright © 2018年 Darren. All rights reserved.
//

import RxSwift

struct ZHEditListViewModel {
    let data = Observable.just([
        ZHDiningRoom(name: "1"),
        ZHDiningRoom(name: "2"),
        ZHDiningRoom(name: "3"),
        ZHDiningRoom(name: "4"),
        ZHDiningRoom(name: "5"),
        ZHDiningRoom(name: "6"),
        ZHDiningRoom(name: "7"),
        ZHDiningRoom(name: "8"),
        ])
}
