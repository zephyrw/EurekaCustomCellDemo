//
//  Software.swift
//  EurekaCustomCellDemo
//
//  Created by Zephyr on 2019/6/4.
//  Copyright © 2019 zephyr. All rights reserved.
//

import Foundation

enum UpdateState: Int {
    case toUpdate = 0
    case updating
    case alreadyNewest
}

struct Software: Equatable {
    var name: String
    var updateState: UpdateState
}

func == (lhs: Software, rhs: Software) -> Bool {
    return lhs.name == rhs.name
}
