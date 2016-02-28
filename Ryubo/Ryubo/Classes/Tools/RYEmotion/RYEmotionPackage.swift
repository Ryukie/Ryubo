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
    lazy var emotions = [RYEmotionModel]()
    
    init(dict: [String: AnyObject],idStr:String) {
        super.init()
        var index = 0
        id = idStr
        group_name_cn = dict["group_name_cn"] as? String
        if let array = dict["emoticons"] as? [[String: String]] {
            //运行测试，发现无法显示图片，原因是 em.png 中只有图片的名称，而没有图片路径
            let dir = id
            for var d in array {
                //拼接路径
                if let png = d["png"] {
                    d["png"] = dir! + "/" + png
                }
                // 追加删除按钮
                if index == 20 {
                    emotions.append(RYEmotionModel(isRemoved: true))
                    index = 0
                }
                index++
                emotions.append(RYEmotionModel(dict: d,id: id!))
            }
        }
        addEmptyButton()
    }
    /// 追加空白按钮
    private func addEmptyButton() {
        let count = emotions.count % 21
        print("数组剩余按钮 \(count)")
        //一页满21 个就什么都不做
        if emotions.count > 0 && count == 0 {
            return
        }
        //有count个  从count开始全部空格
        for _ in count..<20 {
            emotions.append(RYEmotionModel(isEmpty: true))
        }
        // 最末尾追加删除按钮
        emotions.append(RYEmotionModel(isRemoved: true))
    }
    
    override var description: String {
        let keys = ["id", "group_name_cn", "emotions"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
