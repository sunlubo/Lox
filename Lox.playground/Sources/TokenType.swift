//
//  TokenType.swift
//  Lox
//
//  Created by sunlubo on 2018/4/8.
//  Copyright © 2018年 sunlubo. All rights reserved.
//

public enum TokenType {
    // Single-character tokens.
    case leftParen
    case rightParen
    case leftBrace
    case rightBrace
    case comma
    case dot
    case semicolon
    case minus
    case plus
    case star
    case slash
    
    // One or two character tokens.
    case bang
    case bangEqual
    case equal
    case equalEqual
    case greater
    case greaterEqual
    case less
    case lessEqual
    
    // Literals.
    case identifier
    case string
    case number
    
    // Keywords.
    case `class`
    case `func`
    case `var`
    case `if`
    case `else`
    case `for`
    case `while`
    case `return`
    case `true`
    case `false`
    case `nil`
    case and
    case or
    case `super`
    case this
    case print
    
    case eof
}
