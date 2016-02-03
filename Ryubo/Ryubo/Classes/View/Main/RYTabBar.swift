//
//  RYTabBar.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/1/30.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYTabBar: UITabBar {
    override func layoutSubviews() {
        super.layoutSubviews()
//        print(__FUNCTION__)
        //添加四个标签中间一个自定义加号按钮
        addTabrBarBtns()
    }
    
    // MARK: - 重新布局四个标签 为中间的加号按钮留出位置
    func addTabrBarBtns () {
        
//        CGFloat x = 0
//        CGFloat y = 0
        let w = self.bounds.width / 5
        let h = self.bounds.height
        
        let rect = CGRectMake(0, 0, w, h)
        
        var index : CGFloat = 0
        //获取几个标签
        for subView in self.subviews {
//            print(subView) 通过打印发现不光有四个标签   还有一个imageView 也就是上面的一个黑线所以需要判断一下是否为标签
            if subView .isKindOfClass(NSClassFromString("UITabBarButton")!) {
//                print(subView)
                //改变标签位置
                subView.frame = CGRectOffset(rect, index * w, 0)
//                index++
                index += ( index == 1 ?2 : 1 )
            }
        }
        plusBtn.frame = CGRectMake(2*w, 0, w, h)
    }
    
    // MARK: - 懒加载加号按钮
    lazy var plusBtn:UIButton = {
        let button = UIButton()
        //设置背景图片
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        //设置图片
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        self.addSubview(button)
        return button
    }()

}
