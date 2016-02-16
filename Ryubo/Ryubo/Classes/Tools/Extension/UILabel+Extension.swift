//
//  UILabel+Extension.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/16.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

extension UILabel {
// MARK: - 类工厂方法
    class func label(text:String,fontSize:CGFloat,textColor:UIColor) -> UILabel {
        let l = UILabel()
        l.text = text
        l.textColor = textColor
        l.font = UIFont.systemFontOfSize(fontSize)
        //对齐方式
        l.textAlignment = .Center
        l.numberOfLines = 0
        //设置label大小
        l.sizeToFit()
        return l
    }
// MARK: - 便利的构造函数
    convenience init (text:String,fontSize:CGFloat,textColor:UIColor) {
        self.init()
        self.text = text
        self.textColor = textColor
        font = UIFont.systemFontOfSize(fontSize)
        //对齐方式
        textAlignment = .Center
        numberOfLines = 0
        //设置label大小
        sizeToFit()
    }
}
