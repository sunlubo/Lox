//
//  Utils.swift
//  Lox
//
//  Created by sunlubo on 2018/4/8.
//  Copyright © 2018年 sunlubo. All rights reserved.
//

extension Character {

    var isDigit: Bool {
        return ("0"..."9").contains(self)
    }

    var isAlpha: Bool {
        return ("a"..."z").contains(self) || ("A"..."Z").contains(self) || self == "_"
    }

    var isAlphaNumeric: Bool {
        return isDigit || isAlpha
    }
}
