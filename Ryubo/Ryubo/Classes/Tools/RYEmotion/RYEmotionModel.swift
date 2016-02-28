//
//  RYEmotionModel.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionModel: NSObject {
    var id : String?
    /// 表情文字
    var chs: String?
    /// 表情图片文件名
    var png: String? {
        didSet {
            //一个模型 只需要计算一次
            //给imagePath赋值
            //NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(bundleId)/" + "\(png)"
//            if let bundleId = id, imageName = png {
            if let imageName = png {
//                imagePath = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(bundleId)/" + "\(imageName)"
                imagePath = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(imageName)"
            }
        }
    }
    /// emoji 编码
    var code: String? {
        didSet {
            emoji = code?.emoji
        }
    }
    /// emoji 字符串
    var emoji: String?
    
    /// 完整的图像路径   //定义图片绝对路径的属性  计算型属性 每次都会进行计算
    var imagePath: String?
//        {
//        return png == nil ? "" : NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + png!
//    }
    /// 是否删除按钮
    var isRemoved = false
    
    // MARK: - 构造函数
    init(isRemoved: Bool) {
        self.isRemoved = isRemoved
        super.init()
    }
    
    /// 是否空白按钮
    var isEmpty = false
    
    // MARK: - 构造函数
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
        super.init()
    }
    
    
    
    init(dict: [String: AnyObject],id:String) {
        self.id = id
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    override var description: String {
        let keys = ["chs", "png", "code"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
