//
//  DispatchTime+Catagory.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/11.
//  Copyright © 2018年 Darren. All rights reserved.
//

import Foundation

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}
extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
