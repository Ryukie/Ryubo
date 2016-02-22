//
//  RYTabBar.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/1/30.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYTabBar: UITabBar {
    
    //重写init(frame) 系统会默认 当前类的对象 只能通过手写代码的方式创建
    //如果程序员通过xib 创建对象 程序会崩溃
    //表示对象是通过xib创建
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(plusBtn)
    }
// MARK: - 这个是为了保证通过代码创建,通过xib的会报错   这段Xcode 会提醒添加的
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //添加四个标签中间一个自定义加号按钮
        addTabrBarBtns()
    }
    
    // MARK: - 重新布局四个标签 为中间的加号按钮留出位置
    func addTabrBarBtns () {
        let w = self.bounds.width / 5
        let h = self.bounds.height
        
        let rect = CGRectMake(0, 0, w, h)
        
        var index : CGFloat = 0
        
        //获取几个标签
        for subView in self.subviews {
//            print(subView) 通过打印发现不光有四个标签   还有一个imageView 也就是上面的一个黑线所以需要判断一下是否为标签
            if subView .isKindOfClass(NSClassFromString("UITabBarButton")!) {
                //改变标签位置
                subView.frame = CGRectOffset(rect, index * w, 0)
                index += ( index == 1 ?2 : 1 )
            }
        }
        plusBtn.frame = CGRectMake(2*w, 0, w, h)
    }
    
    // MARK: - 懒加载加号按钮
    lazy var plusBtn:UIButton = {//不要在此处添加点击事件  放在控制器里添加  将加号设置为属性让控制器可以拿到
        let button = UIButton(backgroundImageName: "tabbar_compose_button", imageName: "tabbar_compose_icon_add")
        return button
    }()

}
