//
//  UIView+Extension.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
extension UIView {
    //遍历响应者链条获取到导航控制器
    func getNaviFromResponderChain () -> UINavigationController? {
        //遍历响应者链条一直到获取到导航控制器为止
        //从当前页面开始获取下一个响应者
        var nextRe = nextResponder()
        //do - while   在swift中被 repeat - while 替换了
        repeat {
        if let obj = nextRe as? UINavigationController {
//        if ((nextRe as? UINavigationController) != nil) {
//            let obj = nextRe as! UINavigationController
            return obj
            }
            nextRe = nextRe?.nextResponder()
        }while(nextRe != nil)
        return nil
    }
}
