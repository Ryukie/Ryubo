//
//  RYBasicNaviController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYBasicNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
// MARK: - 重写push方法
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count != 0 {
            //在push之前隐藏底部导航栏
            viewController.hidesBottomBarWhenPushed = true
        }
        //这句不能少否则无法跳转
        super.pushViewController(viewController, animated: true)
    }
}
