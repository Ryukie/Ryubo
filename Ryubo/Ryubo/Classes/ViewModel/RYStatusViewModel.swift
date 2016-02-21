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
    var statuses = [RYStatus]()
    static let sharedRYStatusViewModel : RYStatusViewModel = RYStatusViewModel()
    private override init() {
        super.init()
    }
    // MARK: - 加载首页数据
    func loadHomeData(withSetStatuses:([RYStatus]) -> ()) {
        let dataURLString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //获取网络请求管理对象
        let manager = RYNetworkTool.sharedNetTool
        guard let token = RYAccountViewModel.sharedAccountViewModel.token else {
            print("用户未登录")
            SVProgressHUD.showErrorWithStatus("请登录")
            return
        }
        var parameters = ["access_token":token]
        //下拉刷新 需要给服务器传递 since_id
            let since_id = self.statuses.first?.id ?? 0
            if since_id > 0 {
                //将开始点加入参数列表
                parameters["since_id"] = "\(since_id)"
            }
        manager.GET(dataURLString, parameters: parameters, progress: { (_ ) -> Void in
//                SVProgressHUD.show()
            }, success: { (_ , result) -> Void in
            //将数据转化为字典结构
            guard let dict = result as? [String:AnyObject] else {
                print("数据结构错误")
                SVProgressHUD.showErrorWithStatus(netErrorText)
                return
            }
            guard let array = dict["statuses"] as? [[String : AnyObject]] else{
                print("数据结构错误")
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
                //判断是 下拉还是 上拉
                if since_id > 0 {
                    //下拉刷新
                    self.statuses = tempArr + self.statuses
                }else {
                    //首次加载数据
                    self.statuses = tempArr
                }
                
            withSetStatuses(tempArr)
            }) { (_ , error ) -> Void in
                print(error)
                SVProgressHUD.showErrorWithStatus(netErrorText)
        }
    }
}