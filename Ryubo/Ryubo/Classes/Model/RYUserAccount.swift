//
//  RYUserAccount.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/8.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
// MARK: - 使用对解档存储用户信息 需要遵守NSCoding协议
class RYUserAccount: NSObject,NSCoding {
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
// MARK: - 实现协议方法,必须实现的方法
    
    //解归档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        //如果是基本数据类型 可以直接 解归档到具体类型
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }
    //归档操作
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
// MARK: - 保存对象
    func saveAccount () {
        //拼接沙盒路径
//        let path = (NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true).last! as NSString ).stringByAppendingPathComponent("account.plist")
//        print(path)
//        //保存对象
//        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        
        //保存到沙盒中
        //拼接路径 在XCode 7.0正式版中 被搞丢了
        //stringByAppendingbyPathCommant
        let path = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("account.plist")
        print(path)
        //将对象保存到沙盒路径中
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
    }
// MARK: - 读取对象 注意需要设置为类方法
    class func loadAccount () -> RYUserAccount? {
//    func loadAccount () -> RYUserAccount? {
        let path = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString).stringByAppendingPathComponent("account.plist")
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? RYUserAccount {
            return account
        }
        return nil
    }
}
