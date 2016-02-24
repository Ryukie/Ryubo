//
//  EmoticonManager.swift
//  EmoticonKeyboard
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
//表情包的管理者
class EmoticonManager: NSObject {
    
    //分组表情的数组
    lazy var packages = [EmoticonPackages]()
    
    
    override init() {
        super.init()
        self.loadEmoticon()
    }
    
    //加载bundle路径下的表情
    func loadEmoticon() {
        //1.获取bundle 路径下 emoticones.plist文件
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        
        guard let filePath = path else {
            print("文件路径不存在")
            return
        }
        
        //将路径下的文件转换字典
        
        let dict = NSDictionary(contentsOfFile: filePath)!
        
        //1.1 获取 packages对应的数组
        let array = dict["packages"] as! [[String : AnyObject]]
        print(array)
        //2.遍历数据 获取文件的id从而找到 分组表情 文件夹
        for item in array {
            let id = item["id"] as! String
            //3.获取文件夹下 info.plist 文件
            loadGroupEmoticon(id)
        }
    }
    
    
    
    //加载分组表情
    private func loadGroupEmoticon(id: String) {
        
        // 获取info.plist文件
        let path = NSBundle.mainBundle().pathForResource("Info.plist", ofType: nil, inDirectory: "Emoticons.bundle/" + "\(id)")
        guard let filePath = path else {
            print("文件路径不存在")
            return
        }
        
        //获取分组表情 info.plist文件对应的字典
        let dict = NSDictionary(contentsOfFile: filePath)!
        //获取大的分组模型
        let group_name_cn = dict["group_name_cn"] as! String
        let emoticonArray = dict["emoticons"] as! [[String : String]]
        //实例化分组表情模型
        let p = EmoticonPackages(id: id, group_name_cn: group_name_cn, emoticonArray: emoticonArray)
        //添加到数组中
        packages.append(p)
        
    }
}
