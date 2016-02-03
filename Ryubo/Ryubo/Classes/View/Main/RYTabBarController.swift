//
//  RYTabBarController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/1/30.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.redColor()
        replaceTabBar()
        addNaviControllers()
    }
    // MARK: - 系统自带TabBar只读 使用KVC将自定义的TabBar替换掉系统的
    func replaceTabBar () {
        let tabBar = RYTabBar()
        self.setValue(tabBar, forKey: "tabBar")
    }
     func addNaviControllers() {
        addNaviControllers(RYHomeController(), titleName: "主页", imageName: "tabbar_home")
        addNaviControllers(RYMessageController(), titleName: "消息", imageName: "tabbar_message_center")
        addNaviControllers(RYProfileController(), titleName: "我", imageName: "tabbar_profile")
        addNaviControllers(RYDiscoverController(), titleName: "发现", imageName: "tabbar_discover")
    }
    
    // MARK: - 为每个模块控制器嵌套一个导航控制器并添加到标签控制器内
    func addNaviControllers (viewController:UIViewController,titleName:String,imageName:String) {
        let navi = UINavigationController(rootViewController:viewController)
        //统一设置标签和导航的文字
//        navi.title = titleName
        
        //设置不同的title 和 标签文字
        navi.tabBarItem.title = titleName
        navi.navigationItem.title = "Ryukie`sWeibo"
        
        navi.tabBarItem.image = UIImage(named: imageName)
        addChildViewController(navi)
    }
    

}
