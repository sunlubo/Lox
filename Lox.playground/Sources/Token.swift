//
//  Token.swift
//  Lox
//
//  Created by sunlubo on 2018/4/8.
//  Copyright © 2018年 sunlubo. All rights reserved.
//

public struct Token {
    public let type: TokenType
    public let lexeme: String
    public let literal: Any?
    public let line: Int
    
    public init(type: TokenType, lexeme: String, literal: Any?, line: Int) {
        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }
}

extension Token: CustomStringConvertible {
    
    public var description: String {
        return "\(type) \(lexeme) \(literal ?? "")"
    }
}
