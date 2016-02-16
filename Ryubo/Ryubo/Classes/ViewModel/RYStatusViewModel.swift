//
//  RYStatusViewModel.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/16.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SVProgressHUD

class RYStatusViewModel: NSObject {
    
    
    
    // MARK: - 加载首页数据
    func loadHomeData(withSetStatuses:([RYStatus])->()) {
        let dataURLString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //获取网络请求管理对象
        let manager = RYNetworkTool.sharedNetTool
        guard let token = RYAccountViewModel().token else {
            print("用户未登录")
            SVProgressHUD.showErrorWithStatus("请登录")
            return
        }
        let parameters = ["access_token":token]
        manager.GET(dataURLString, parameters: parameters, progress: nil , success: { (_ , result) -> Void in
            //                            print(result)
            //将数据转化为字典结构
            guard let dict = result as? [String:AnyObject] else {
//                print("数据结构错误")
                SVProgressHUD.showErrorWithStatus(netErrorText)
                return
            }
            guard let array = dict["statuses"] as? [[String : AnyObject]] else{
//                print("数据结构错误")
                SVProgressHUD.showErrorWithStatus(netErrorText)
                return
            }
            var tempArr = [RYStatus]()//容器
            //获取必选的 字典数组
            //便利数组 做字典转模型
            for item in array {
                let i = RYStatus(dict: item)//KVC
                tempArr.append(i)
            }
            withSetStatuses(tempArr)
            }) { (_ , error ) -> Void in
                print(error)
                SVProgressHUD.showErrorWithStatus(netErrorText)
        }
    }
}
