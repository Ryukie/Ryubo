//
//  RYHomeController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/1/30.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

class RYHomeController: RYBasicVisitorTVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        visitorView?.setVisitorViewWithInfo(nil, titleText: "关注一些人，你将打开新世界的大门")
//        demoAFN()
        loadHomeData()
    }
// MARK: - AFN demo
    private func demoAFN () {
        let urlString = "http://www.weather.com.cn/data/sk/101010100.html"
        //获取网络请求对象
        let manager = RYNetworkTool.sharedNetTool
        //设置反序列化支持的格式
        //使用字典进行参数传递
        //网络请求前,显示指示器
        SVProgressHUD.showInfoWithStatus("正在加载网络数据...")
        manager.GET(urlString, parameters: nil, progress: nil, success: { (task, result) -> Void in
            SVProgressHUD.dismiss()
//            print(result)
            }) { (task, error) -> Void in
                SVProgressHUD.showInfoWithStatus("请检查网络...")
                print(error)
        }
    }
    
// MARK: - 加载首页数据
    private func loadHomeData() {
        let dataURLString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //获取网络请求管理对象
        let manager = RYNetworkTool.sharedNetTool
        guard let token = RYAccountViewModel().token else {
            print("用户未登录")
            return
        }
        let parameters = ["access_token":token]
        manager.GET(dataURLString, parameters: parameters, progress: nil , success: { (_ , result) -> Void in
//                            print(result)
            //将数据转化为字典结构
            guard let dict = result as? [String:AnyObject] else {
                print("数据结构错误")
                return
            }
            guard let array = dict["statuses"] as? [[String : AnyObject]] else{
                print("数据结构错误")
                return
            }
            //获取必选的 字典数组
            //便利数组 做字典转模型
            for item in array {
                print(item)
            }
            }) { (_ , error ) -> Void in
                print(error)
        }
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


}
