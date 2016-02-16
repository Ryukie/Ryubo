//
//  RYUser.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/16.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYUser: NSObject {
    ///用户id
    var id: Int64 = 0
    ///用户名称
    var name: String?
    ///用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
    //计算用户头像的url地址
    var headImageURL: NSURL? {
        return NSURL(string: profile_image_url ?? "")
    }
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人  草根
    var verified_type: Int = -1
    
    var verified_type_image: UIImage? {
        switch verified_type {
        case -1: return nil
        case 0: return UIImage(named: "avatar_vip")
        case 2,3,5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default : return nil
        }
    }
    /// 会员等级 0-6
    var mbrank: Int = 0
    var mbrank_image: UIImage? {
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        return nil
    }
    
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    //重写对象的描述信息
    override var description: String {
        //使用kvc方式 获取对象 的字典信息
        let keys = ["name","id","profile_image_url","mbrank","verified_type"]
        let dict = self.dictionaryWithValuesForKeys(keys)
        return dict.description
    }
}
