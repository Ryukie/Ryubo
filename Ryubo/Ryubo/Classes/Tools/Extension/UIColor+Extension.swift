//
//  UIColor+Extension.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/23.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
extension UIColor {
    class func randomColor () -> UIColor{
        //随机色
        let red =  CGFloat(random() % 256) / 255.0
        let green = CGFloat(random() % 256) / 255.0
        let blue = CGFloat(random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}