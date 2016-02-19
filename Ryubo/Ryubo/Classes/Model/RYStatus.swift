//
//  RYStatus.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/16.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYStatus: NSObject {
    var created_at: String?
    //微博id
    ///微博Id  OC: id是任意对象的关键字
    //Int  NSInteger  在iPhone 5 5c 4s 4 是32
    //Int 64  long long
    var id: Int64 = 0
    //微博正文
    var text: String?
    //微博来源
    var source: String?
    //配图数组
    var pic_urls: [[String : String]]? {
        didSet {
            //遍历数组转化为URL并保存到URL数组中
            if let URLStrings = pic_urls where URLStrings.count != 0 {
                picURLs = [NSURL]()
                for item in URLStrings {
                    let URLString = item["thumbnail_pic"]
                    let picURL = NSURL(string:URLString!)
                    picURLs?.append(picURL!)
                }
                print(picURLs)
            }
        }
    }
    //配图URLs
    var picURLs : [NSURL]?
    //用户
    var user : RYUser?
    
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    //KVC
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            //value 就是一个字典对象
            if let dict = value as? [String : AnyObject] {
                //能够转化为[String : AnyObject]字典对象
                //字典转模型
                user = RYUser(dict: dict)
                //return  非常非常关键  前面的字典转模型 就白做了
                return
            }
        }
        //不是User的数据的话按默认方式KVC
        super.setValue(value, forKey: key)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    //重写对象的描述信息
    override var description: String {
        //使用kvc方式 获取对象 的字典信息
        let keys = ["created_at","id","text","source"]
        let dict = self.dictionaryWithValuesForKeys(keys)
        return dict.description
    }
    
    
}
