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
    func loadHomeData(isPulling: Bool, finished: (isSuccess: Bool) -> ()) {
//        let dataURLString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let dataURLString = "2/statuses/home_timeline.json"
        //获取网络请求管理对象
        let manager = RYNetworkTool.sharedNetTool
        guard let token = RYAccountViewModel.sharedAccountViewModel.token else {
            print("用户未登录")
            SVProgressHUD.showErrorWithStatus("请登录")
            return
        }
        var parameters = ["access_token":token]
        
        //下拉刷新 需要给服务器传递 since_id
        //上拉加载更多许要传递 max_id参数
        //since_id 和 max_id 互斥参数 二者只能传递一个
        var since_id: Int64 = 0
        var max_id: Int64 = 0
        if isPulling {
            //上拉加载更多数据
            max_id = self.statuses.last?.id ?? 0
        } else {
            //下拉刷新
            since_id = self.statuses.first?.id ?? 0
        }
        //下拉刷新 需要给服务器传递 since_id
        if since_id > 0 {
            //将开始点加入参数列表
            parameters["since_id"] = "\(since_id)"
        }
        if max_id > 0 {
//            parameters["max_id"] = "\(max_id)"//上拉重复一条数据
            parameters["max_id"] = "\(max_id-1)"
        }
        
        manager.requestSend(.GET, URLString: dataURLString, parameter: parameters) { (success, error) -> () in
            if error != nil {
                finished(isSuccess: false)
                print(error)
                SVProgressHUD.showErrorWithStatus(netErrorText)
                return
            }
            //将数据转化为字典结构
            guard let dict = success else {
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
                //下拉
                self.statuses = tempArr + self.statuses
            } else if max_id > 0 {
                //上拉
                self.statuses += tempArr
            } else {
                //首次加载数据
                self.statuses = tempArr
            }
            finished(isSuccess: true)
        }
    }
}