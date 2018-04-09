//
//  Scanner.swift
//  Lox
//
//  Created by sunlubo on 2018/4/8.
//  Copyright © 2018年 sunlubo. All rights reserved.
//

public final class Scanner {
    private static let keywords: [String: TokenType] = [
        "class": .class, "func": .func, "var": .var,
        "if": .if, "else": .else, "for": .for, "while": .while, "return": .return,
        "true": .true, "false": .false, "nil": .nil,
        "and": .and, "or": .or,
        "super": .super, "this": .this,
        "print": .print
    ]
    
    private let source: String
    private var tokens: [Token]
    private var start: String.Index
    private var current: String.Index
    private var line = 1
    
    public init(source: String) {
        self.source = source
        self.tokens = []
        self.start = source.startIndex
        self.current = source.startIndex
    }
    
    public func scanTokens() -> [Token] {
        while !isAtEnd() {
            // We are at the beginning of the next lexeme.
            start = current
            scanToken()
        }
        
        tokens.append(Token(type: .eof, lexeme: "", literal: nil, line: line))
        return tokens
    }
    
    private func scanToken() {
        let c = advance()
        switch c {
        case "(": addToken(type: .leftParen)
        case ")": addToken(type: .rightParen)
        case "{": addToken(type: .leftBrace)
        case "}": addToken(type: .rightBrace)
        case ",": addToken(type: .comma)
        case ".": addToken(type: .dot)
        case ";": addToken(type: .semicolon)
        case "-": addToken(type: .minus)
        case "+": addToken(type: .plus)
        case "*": addToken(type: .star)
        case "!": addToken(type: match(expected: "=") ? .bangEqual : .bang)
        case "=": addToken(type: match(expected: "=") ? .equalEqual : .equal)
        case "<": addToken(type: match(expected: "=") ? .lessEqual : .less)
        case ">": addToken(type: match(expected: "=") ? .greaterEqual : .greater)
        case "/":
            if match(expected: "/") {
                // A comment goes until the end of the line.
                while peek() != "\n" && !isAtEnd() {
                    advance()
                }
            } else {
                addToken(type: .slash)
            }
        case " ", "\r", "\t":
            // Ignore whitespace.
            ()
        case "\n":
            line += 1
        case "\"": string()
        default:
            if c.isDigit {
                number()
            } else if c.isAlpha {
                identifier()
            } else {
                error(line: line, message: "Unexpected character.")
            }
        }
    }
    
    private func addToken(type: TokenType, literal: Any? = nil) {
        let text = source[start..<current]
        tokens.append(Token(type: type, lexeme: String(text), literal: literal, line: line))
    }
    
    private func isAtEnd() -> Bool {
        return current >= source.endIndex
    }
    
    @discardableResult
    private func advance() -> Character {
        current = source.index(after: current)
        return source[source.index(before: current)]
    }
    
    private func peek() -> Character {
        if isAtEnd() { return "\0" }
        return source[current]
    }
    
    private func peekNext() -> Character {
        if source.index(after: current) >= source.endIndex { return "\0" }
        return source[source.index(after: current)]
    }
    
    private func match(expected: Character) -> Bool {
        if isAtEnd() { return false }
        if source[current] != expected { return false }
        
        current = source.index(after: current)
        return true
    }
    
    private func string() {
        while peek() != "\"" && !isAtEnd() {
            if peek() == "\n" {
                line += 1
            }
            advance()
        }
        
        // Unterminated string.
        if isAtEnd() {
            error(line: line, message: "Unterminated string.")
            return
        }
        
        // The closing ".
        advance()
        
        // Trim the surrounding quotes.
        let value = source[source.index(after: start)..<source.index(before: current)]
        addToken(type: .string, literal: value)
    }
    
    private func number() {
        while peek().isDigit {
            advance()
        }
        
        // Look for a fractional part.
        if peek() == "." && peekNext().isDigit {
            // Consume the "."
            advance()
            
            while peek().isDigit {
                advance()
            }
        }
        
        let value = source[start..<current]
        addToken(type: .number, literal: Double(value))
    }
    
    private func identifier() {
        while peek().isAlphaNumeric {
            advance()
        }
        
        // See if the identifier is a reserved word.
        let text = source[start..<current]
        
        if let type = Scanner.keywords[String(text)] {
            addToken(type: type)
        } else {
            addToken(type: .identifier)
        }
    }
}
