//
//  RYBasicNaviController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYBasicNaviController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置 右滑 手势代理
        //The gesture recognizer responsible for popping the top view controller off the navigation stack. (read-only)
        //The navigation controller installs this gesture recognizer on its view and uses it to pop the topmost view controller off the navigation stack. You can use this property to retrieve the gesture recognizer and tie it to the behavior of other gesture recognizers in your user interface. When tying your gesture recognizers together, make sure they recognize their gestures simultaneously to ensure that your gesture recognizers are given a chance to handle the event.
        interactivePopGestureRecognizer?.delegate = self
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
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(childViewControllers.count)
        //YEStrue (the default) to tell the gesture recognizer to proceed with interpreting touches, NOfalse to prevent it from attempting to recognize its gesture.
        return childViewControllers.count > 1
    }
    
}
