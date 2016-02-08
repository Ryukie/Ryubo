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
        demoAFN()
    }
// MARK: - AFN demo
    private func demoAFN () {
        let urlString = "http://www.weather.com.cn/data/sk/101010100.html"
        //获取网络请求对象
//        let manager = AFHTTPSessionManager()
        let manager = RYNetworkTool.sharedNetTool
        //NSLocalizedDescription=Request failed: unacceptable content-type: text/html
        //设置反序列化支持的格式
//        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
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
