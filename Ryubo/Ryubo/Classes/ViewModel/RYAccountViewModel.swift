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
// MARK: - 构造函数私有化   保证不会通过构造函数创建新的对象
    private override init() {
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
        if let urlString = userAccount?.avatar_large {
            return NSURL(string: urlString)
        }
        return nil
    }
    
    func getAccessToken(code:String , finished:(isLogin:Bool)->()) {
        let URLString = "oauth2/access_token"
        let parameters = [
            "client_id":app_key,
            "client_secret": app_scret,
            "grant_type":"authorization_code",
            "code": code,
            "redirect_uri": redirect_URL
        ]
        let manager = RYNetworkTool.sharedNetTool
        //用这个方法才对
        manager.requestSend(.POST, URLString: URLString, parameter: parameters) { (success, error) -> () in
            if error != nil {
                finished(isLogin: false)
                print(error)
                return
            }
            finished(isLogin: true)
            //对象转字典成功后
            let account = RYUserAccount(dict: success!)
            //设置用户数据
            self.loadUserInfo(account,finished: finished)
        }
    }
    private func loadUserInfo(account:RYUserAccount,finished:(isLogin:Bool)->()){
        //用户数据接口
        let urlString = "2/users/show.json"
        //需要传递的参数
        //OC  {"nullobject" : [NSNull null]}
        // MARK: - 程序员保证这个地方一定有值,否则参数哪里会报错
        let parameters = ["access_token": account.access_token!, "uid": account.uid!]//字典不能存放空对象   要存只能存[NSNull null]对象
        let manager = RYNetworkTool.sharedNetTool
        manager.requestSend(.GET, URLString: urlString, parameter: parameters) { (success, error) -> () in
            if error != nil {
                finished(isLogin: false)
                return
            }
            finished(isLogin: true)
            let name = success!["name"] as! String //OC NSString 转String
            let avatar_large = success!["avatar_large"] as! String
            //我们需要的用户信息就全部获取到
            account.name = name
            account.avatar_large = avatar_large
            account.saveAccount()
            // MARK: - 需要更新用户属性否则切换视图的时候还是显示的是未登录的首页
            self.userAccount = account            
        }
    }
    
}
