//
//  RYVisitorView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/3.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYVisitorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    //默认实现报错
    //当程序员通过 sb / xib 加载该视图 程序就会崩溃
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadUI () {
        self.backgroundColor = UIColor.redColor()
        addSubview(iv_circleIcon)
    }
// MARK: - 懒加载控件
    //环形图片
    lazy var iv_circleIcon:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //大房子图片
    lazy var iv_bigHouse:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    //提示文案
    lazy var lb_notiText:UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFontOfSize(14)
        l.text = "注册登陆开启新世界的大门哦~"
        l.textColor = UIColor.darkGrayColor()
        //对齐方式
        l.textAlignment = .Center
        //设置label大小
        l.sizeToFit()
        return l
    }()
    //登陆按钮
    lazy var bt_toLogin:UIButton = {
        let b = UIButton()
        b.setTitle("Login", forState: .Normal)
        b.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        b.titleLabel?.font = UIFont.systemFontOfSize(18)
        return b
    }()
    
    //注册按钮
    lazy var bt_toRegister:UIButton = {
        let b = UIButton()
        b.setTitle("Register", forState: .Normal)
        b.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        b.titleLabel?.font = UIFont.systemFontOfSize(18)
        return b
    }()
}
