//
//  RYEmotionPackage.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionPackage: NSObject {
    /// 表情包路径名，浪小花的数据需要修改
    var id: String?
    /// 表情包名称
    var group_name_cn: String?
    /// 表情包数组
    lazy var emoticons = [RYEmotionModel]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        id = dict["id"] as? String
        group_name_cn = dict["group_name_cn"] as? String
        if let array = dict["emoticons"] as? [[String: String]] {
            for d in array {
                emoticons.append(RYEmotionModel(dict: d))
            }
        }
    }
    override var description: String {
        let keys = ["id", "group_name_cn", "emoticons"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
