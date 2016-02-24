//
//  EmoticonPackages.swift
//  EmoticonKeyboard
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit


/*

每隔20个按钮需要一个删除按钮
页面表情不足21个需要补足 空表情

*/

class EmoticonPackages: NSObject {
    //分组表情的文件名称
    var id: String?
    //分组表情的中文名称
    var group_name_cn: String?
    
    //分组表情包下 所以的表情数组
    var emoticons = [Emoticon]()
    
    
    init(id: String, group_name_cn: String, emoticonArray: [[String : String]]) {
        self.id = id
        self.group_name_cn = group_name_cn
        super.init()
        //需要将字典数组 转换为 模型数组
        
        var index = 0
        for item in emoticonArray {
            let e = Emoticon(id: id, dict: item)
            //给模型的id赋值
            if index == 20 {
                //添加一个删除按钮的模型
                let delete = Emoticon(isDelete: true)
                //添加到数组中
                emoticons.append(delete)
                
                //恢复标记
                index = 0
            }
            
            
            emoticons.append(e)
            
            index++
            
        }
        
        //给每一组的最后一页 添加空白表情
        self.addEmptyEmotion()
        
    }
    
    
    private func addEmptyEmotion() {
        //每页不足二十一个表情就需要添加空表情
        let delta = emoticons.count % 21
        print("需要添加\(21 - delta)空表情")
        if delta == 0 {
            return
        }
        
        for _ in delta..<20 {
            //添加空表情
            let e = Emoticon(isEmpty: true)
            //添加到数组中
            emoticons.append(e)
        }
        //最后一个添加一个删除按钮
        let delete = Emoticon(isDelete: true)
        emoticons.append(delete)
    }
}
