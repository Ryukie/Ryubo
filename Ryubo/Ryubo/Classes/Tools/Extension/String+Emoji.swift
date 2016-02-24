//
//  String+Emoji.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import Foundation
extension String {
    // 从当前 16 进制字符串中扫描生成 emoji 字符串
    var emoji: String {
        let scanner = NSScanner(string: self)
        var value: UInt32 = 0
        scanner.scanHexInt(&value)
        return String(Character(UnicodeScalar(value)))
    }
}
