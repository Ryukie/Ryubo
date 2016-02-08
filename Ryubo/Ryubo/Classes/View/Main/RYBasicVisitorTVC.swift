//
//  RYBasicVisitorTVC.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/3.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
//OC中 经典的面试题
//OC中有多继承吗? 如果没有 用什么替代 协议
//在OC中没有实现必选的协议方法 报警告 在swift中 没有实现 '必选' 的协议方法  直接报error
class RYBasicVisitorTVC: UITableViewController,RYVisitorViewDelegate {
    
    //定义用户是否登录的标示
//    var userLogin = true
//    var userLogin = false
    var userLogin = RYUserAccount.loadAccount() != nil

    
// MARK: - 为了自定义不同的访客视图需要将访客视图设置为属性
    var visitorView:RYVisitorView?
    
    //loadView
    //1. -苹果专门为 手写代码准备的 一旦实现该方法 sb / xib 会自动失效
    //2. 准备视图层次结构 在UIViewController 中 会将view 准备出来
    //3. 在super.loadView之前 view没有被创建出来(nil) 追踪view 会造成递归调用
    override func loadView() {
        userLogin ? super.loadView() : setupVisitorView()
    }
    // MARK: - 加载访客视图
    private func setupVisitorView () {
        visitorView = RYVisitorView()
        // MARK: - 设置代理属性
        visitorView?.delegate = self
        view = visitorView
// MARK: - 设置导航条Items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Login", style: .Plain, target: self, action: "userWillLogin")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .Plain, target: self, action: "userWillRegister")
    }
    //会在 viewwillLayoutsubViews方法中 设置view的大小
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
// MARK: - 实现代理方法
    func userWillLogin() {
//        print(__FUNCTION__)
        //跳转到授权页面
        let authViewC = RYAuthController()
        //需要使用一个导航控制器包装一下
        let navi = UINavigationController(rootViewController: authViewC)
        self.navigationController?.presentViewController(navi, animated: true, completion: nil)
    }
    func userWillRegister() {
        print(__FUNCTION__)
    }

}
