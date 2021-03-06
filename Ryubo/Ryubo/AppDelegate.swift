//
//  AppDelegate.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/1/30.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import AFNetworking
//import AFNetworkActivityIndicatorManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupGlobalNaviColor()
        registerNotiCenter()
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.blueColor()
        window?.rootViewController = setRootViewController()
        window?.makeKeyAndVisible()
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        return true
    }
// MARK: - 设置全局渲染色
    private func setupGlobalNaviColor () {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }
    
    private func setRootViewController () -> UIViewController {
        return RYAccountViewModel.sharedAccountViewModel.userLogin ? RYWelcomeController() : RYTabBarController()
    }
// MARK: - 注册通知中心
    private func registerNotiCenter () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeRootViewDidReciveNoti:", name: didLoginChangeToWeiboView, object: nil)
    }
// MARK: - 通知调用的方法,切换视图
    @objc private func changeRootViewDidReciveNoti (noti:NSNotification) {
//        print(__FUNCTION__)
        // MARK: - 需要实现登陆成功的话先切换到欢迎界面,需要判断
        window?.rootViewController = (noti.object != nil ? RYTabBarController() : RYWelcomeController())
    }
// MARK: - 移除通知,规范
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
