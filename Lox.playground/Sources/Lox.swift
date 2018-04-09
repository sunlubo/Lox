//
//  Lox.swift
//  Lox
//
//  Created by sunlubo on 2018/4/8.
//  Copyright © 2018年 sunlubo. All rights reserved.
//

var hadError = false

func error(line: Int, message: String) {
    report(line: line, file: "", message: message)
}

func report(line: Int, file: String, message: String) {
    print("[line \(line)] Error\(file): \(message)")
    hadError = true
}

public func run(source: String) {
    let scanner = Scanner(source: source)
    let tokens = scanner.scanTokens()

    for token in tokens {
        print(token)
    }
}
