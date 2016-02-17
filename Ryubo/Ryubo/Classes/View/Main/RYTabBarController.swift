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
        print(self)
//        self.view.backgroundColor = UIColor.redColor()
        replaceTabBar()
        addNaviControllers()
    }
    // MARK: - 系统自带TabBar只读 使用KVC将自定义的TabBar替换掉系统的
    private func replaceTabBar () {
        let tabBar = RYTabBar()
        self.setValue(tabBar, forKey: "tabBar")
        // MARK: - 为加号按钮添加点击事件
        tabBar.plusBtn.addTarget(self, action: "clickPlusBtn", forControlEvents: .TouchUpInside)
    }
    
     private func addNaviControllers() {
        addNaviControllers(RYHomeController(), titleName: "主页", imageName: "tabbar_home")
        addNaviControllers(RYMessageController(), titleName: "消息", imageName: "tabbar_message_center")
        addNaviControllers(RYProfileController(), titleName: "我", imageName: "tabbar_profile")
        addNaviControllers(RYDiscoverController(), titleName: "发现", imageName: "tabbar_discover")
    }
    
    // MARK: - 为每个模块控制器嵌套一个导航控制器并添加到标签控制器内
    private func addNaviControllers (viewController:UIViewController,titleName:String,imageName:String) {
        let navi = UINavigationController(rootViewController:viewController)
        //统一设置标签和导航的文字
        viewController.title = titleName
        viewController.tabBarItem.image = UIImage(named: imageName)
        addChildViewController(navi)
    }
    
    // MARK: - 家号按钮点击事件
    @objc private func clickPlusBtn () {
    }

}
