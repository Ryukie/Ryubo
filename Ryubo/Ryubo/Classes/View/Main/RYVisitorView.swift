//
//  RYVisitorView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/3.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SnapKit //导入SnapKit命名空间

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
        self.backgroundColor = UIColor.whiteColor()
        addSubview(iv_circleIcon)
        addSubview(iv_bigHouse)
        addSubview(bt_toLogin)
        addSubview(bt_toRegister)
        addSubview(lb_notiText)
        
        //设置自动布局 苹果手码布局 通过 VFL NSLayoutConstraint
        /*
        1.item: 表示要设置约束的对象
        2.attribute: 需要添加约束的属性
        3.relatedBy: 参照方法 一般使用 精准参照 .Equal\
        4.toItem: 约束被参照的对象
        attribute:被参照约束的属性
        view1.attr1 = view2.attr2 * multiplier + constant
        */
        
        // MARK: - 通过SnapKit布局子控件
        /*
        添加约束 推荐 使用链式约束
        */
        //snp_makeConstraints 表示添加一条约束
        iv_circleIcon.snp_makeConstraints { (make) -> Void in
            //水平居中
            make.centerX.equalTo(self.snp_centerX)
            //垂直居中  并且向上偏移80
            make.centerY.equalTo(self.snp_centerY).offset(-80)
        }
        iv_bigHouse.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(iv_circleIcon.snp_center)
        }
        lb_notiText.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iv_circleIcon)
            make.top.equalTo(iv_circleIcon.snp_bottom).offset(16)
            make.width.equalTo(225)
        }
        bt_toLogin.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(lb_notiText.snp_left)
            make.top.equalTo(lb_notiText.snp_bottom).offset(16)
            make.width.equalTo(100)
        }
        bt_toRegister.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(lb_notiText.snp_right)
            make.top.equalTo(lb_notiText.snp_bottom).offset(16)
            make.width.equalTo(100)
        }
        
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
        l.numberOfLines = 0
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
        let image = UIImage(named: "common_button_white_disable")!
        let edg:UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        b.setBackgroundImage(image.resizableImageWithCapInsets(edg), forState: .Normal)
        return b
    }()
    
    //注册按钮
    lazy var bt_toRegister:UIButton = {
        let b = UIButton()
        b.setTitle("Register", forState: .Normal)
        b.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        b.titleLabel?.font = UIFont.systemFontOfSize(18)
        
        let image = UIImage(named: "common_button_white_disable")!
//        let w = Int(image.size.width * 0.5)
//        let h = Int(image.size.height * 0.5)
        let edg:UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        b.setBackgroundImage(image.resizableImageWithCapInsets(edg), forState: .Normal)
        return b
    }()
}
