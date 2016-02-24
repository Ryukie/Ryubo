//
//  Emoticon.swift
//  EmoticonKeyboard
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class Emoticon: NSObject {

    var id: String?
    
    //表情文字
    var chs: String?
    //表情图片名称
    var png: String? {
        didSet {
            //一个模型 只需要计算一次
            //给imagePath赋值
            //NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(bundleId)/" + "\(png)"
            if let bundleId = id, imageName = png {
                imagePath = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + "\(bundleId)/" + "\(imageName)"
            }
            
        }
    }
    
    //定义图片绝对路径的属性  计算型属性 每次都会进行计算
    var imagePath: String?
    
    //emoji表情的字符串(十六进制的字符串)
    var code: String? {
        didSet {
            if let codeStr = code {
                emojiStr = codeStr.emojiStr()
            }
        }
    }
    
    var emojiStr: String?
    
    //标记是否是删除按钮
    var isDelete = false
    
    
    //标记是否是空白表情的模型
    var isEmpty = false
    
    init(id: String,dict: [String : String]) {
        self.id = id
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    //添加删除按钮的构造方法 
    init(isDelete: Bool) {
        self.isDelete = isDelete
        super.init()
    }
    
    
    //添加空表情的构造方法
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
        super.init()
    }
    
    //过滤
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {    }
    
    
    //重写对象的描述信息
    override var description: String {
        //使用kvc方式 获取对象 的字典信息
        let keys = ["chs","png","code","id"]
        let dict = self.dictionaryWithValuesForKeys(keys)
        return dict.description
    }
}
