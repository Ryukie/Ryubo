//
//  RYAccountViewModel.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/8.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYAccountViewModel: NSObject {
    static let sharedAccountViewModel : RYAccountViewModel = RYAccountViewModel()
    var userAccount:RYUserAccount?
    override init() {
        userAccount = RYUserAccount.loadAccount()
        super.init()
    }
    
    //用户是否登录的标记
    var userLogin:Bool {
        return userAccount?.access_token != nil //swift不存在非0即真注意
//        return false
    }
    
    //从缓存获取token
    var token : String? {
        return userAccount?.access_token
    }
    
    //用户昵称
    var userName : String? {
        return userAccount?.name
    }
    
    //用户头像
    var userHeadIconURL : NSURL? {
//        return NSURL(string: (userAccount?.avatar_large)!)
        return NSURL(string: userAccount?.avatar_large ?? "")
    }
    
    func getAccessToken(code:String , finished:(isLogin:Bool)->()) {
        let URLString = "https://api.weibo.com/oauth2/access_token"
        let parameters = [
            "client_id":app_key,
            "client_secret": app_scret,
            "grant_type":"authorization_code",
            "code": code,
            "redirect_uri": redirect_URL
        ]
        let manager = RYNetworkTool.sharedNetTool
        //用这个方法才对
        manager.POST(URLString, parameters: parameters, progress: nil, success: { (_ , result) -> Void in
            //将 Anyobject对象转换为 字典格式数据
            guard let dict = result as? [String : AnyObject] else {
                print("数据格式不合法")
                //执行失败的回调
                finished(isLogin: false)
                return
            }
            //执行成功的回调
            finished(isLogin: true)
            //对象转字典成功后
            let account = RYUserAccount(dict: dict)
            //设置用户数据
            self.loadUserInfo(account,finished: finished)
            }) { (_ , error) -> Void in
                finished(isLogin: false)
                print(error)
        }
    }
    private func loadUserInfo(account:RYUserAccount,finished:(isLogin:Bool)->()){
        //用户数据接口
        let urlString = "https://api.weibo.com/2/users/show.json"
        //需要传递的参数
        //OC  {"nullobject" : [NSNull null]}
        // MARK: - 程序员保证这个地方一定有值,否则参数哪里会报错
        let parameters = ["access_token": account.access_token!, "uid": account.uid!]//字典不能存放空对象   要存只能存[NSNull null]对象
        let manager = RYNetworkTool.sharedNetTool
        manager.GET(urlString, parameters: parameters, progress: nil, success: { (_, result) -> Void in
            //            print(result)
            // MARK: - 将用户数据转化为字典
            guard let dict = result as? [String:AnyObject] else {
                print("数据格式不和法")
                //执行失败的回调
                finished(isLogin: false)
                return
            }
            //执行成功的回调
            finished(isLogin: true)
            let name = dict["name"] as! String //OC NSString 转String
            let avatar_large = dict["avatar_large"] as! String
            //我们需要的用户信息就全部获取到
            account.name = name
            account.avatar_large = avatar_large
//            print(account)
            account.saveAccount()
// MARK: - 需要更新用户属性否则切换视图的时候还是显示的是未登录的首页
            self.userAccount = account
//            print(self.userLogin)
            
            }) { (_ , error) -> Void in
                print(error)
                finished(isLogin: false)
        }
    }
    
}
