//
//  RYUserAccount.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/8.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYUserAccount: NSObject {
    //用于调用access_token，接口获取授权后的access token。
    var access_token: String?
    //access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0
    //当前授权用户的UID。
    var uid: String?
    //用户名称
    var name: String?
    // 用户头像地址（大图），180×180像素
    var avatar_large: String?
    
// MARK: - KVC设置值
    init(dict:[String :AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //unDefinedKey
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    //重写描述信息
    override var description:String {
        //使用kvc方式 获取对象 的字典信息
        let keys = ["access_token","expires_in","uid","name","avatar_large"]
        let dict = self.dictionaryWithValuesForKeys(keys)
        return dict.description
    }
}
