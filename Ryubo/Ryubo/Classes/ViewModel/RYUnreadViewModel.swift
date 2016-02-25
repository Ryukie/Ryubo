//
//  RYUnreadViewModel.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/25.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYUnreadViewModel: NSObject {
    var unreadStatus : RYUnread?
    static let sharedUnreadViewModel : RYUnreadViewModel = RYUnreadViewModel()
    private override init() {
        super.init()
    }
    func setBadgeForTabBarItem (tabBarItem : UITabBarItem) {
        /*
        必选	类型及范围	说明
        source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
        access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
        uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
        callback	false	string	JSONP回调函数，用于前端调用返回JS格式的信息。
        unread_message	false	boolean	未读数版本。0：原版未读数，1：新版未读数。默认为0。
        */
        let account = RYAccountViewModel.sharedAccountViewModel.userAccount
        let uid = (account?.uid)! as NSString
        var parameter = [String : AnyObject]()
        parameter["access_token"] = account?.access_token
        parameter["uid"] = uid.integerValue
        RYNetworkTool.sharedNetTool.requestSend(.GET, URLString: "2/remind/unread_count.json", parameter: parameter) { (success, error) -> () in
            if success != nil {
                let dict = success! as [String:AnyObject]
                let unread = RYUnread(dict: dict)
                print(unread.status)
                if unread.status != 0 {
                    tabBarItem.badgeValue = "\(unread.status)"
                }else {
                    tabBarItem.badgeValue = nil
                }
            }else {
                print(error)
            }
        }
    }
}
