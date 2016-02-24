//
//  RYEmotionViewManager.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionViewManager: NSObject {
    static let sharedEmotionManager = RYEmotionViewManager()
    // 表情包数组
    lazy var packages = [RYEmotionPackage]()
    private override init() {
        super.init()
        //从plist加载表情包信息
        // 1. emoticons.plist 路径
        guard let filePath = NSBundle.mainBundle().pathForResource("emoticons", ofType: "plist",inDirectory: "Emoticons.bundle") else {
            print("文件不存在")
            return
        }
        // 2. 加载字典
        guard let dict = NSDictionary(contentsOfFile: filePath) else {
            print("数据错误")
            return
        }
        // 3. 提取 packages 中的 id 字符串对应的数组
        // valueForKey  可以获得数组
        let idArr = (dict["packages"] as! NSArray).valueForKey("id") as! [String]
        // 4. 遍历数组，字典转模型
        for id in idArr {
            loadInfoPlist(id)
        }
    }
    /// 加载 id 目录下的 info.plist 文件
    private func loadInfoPlist(id: String) {
        print(id)
        let filePath = NSBundle.mainBundle().pathForResource("info", ofType: "plist", inDirectory: "Emoticons.bundle/\(id)")
        let dict = NSDictionary(contentsOfFile: filePath!) as! [String: AnyObject]
        packages.append(RYEmotionPackage(dict: dict))
    }
}
