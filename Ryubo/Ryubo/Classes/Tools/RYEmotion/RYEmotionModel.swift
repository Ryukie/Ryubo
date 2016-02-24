//
//  RYEmotionModel.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionModel: NSObject {
    /// 表情文字
    var chs: String?
    /// 表情图片文件名
    var png: String?
    /// emoji 编码
    var code: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    override var description: String {
        let keys = ["chs", "png", "code"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
