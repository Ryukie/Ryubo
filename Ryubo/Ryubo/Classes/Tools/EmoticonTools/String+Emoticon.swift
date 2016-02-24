//
//  String+Emoticon.swift
//  EmoticonKeyboard
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import Foundation

extension String {
    
    func emojiStr() -> String {
        let scanner = NSScanner(string: self)
        //扫描字符串中的 十六进制的字符串
        var value: UInt32 = 0
        //将扫描到的字符串转换为整数 输入到 value对应的地址下
        scanner.scanHexInt(&value)
        
        //将十六进制的数组 转换为 unicode 字符
        let result = Character(UnicodeScalar(value))
        
        return "\(result)"
    }
}