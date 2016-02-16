//
//  RYVisitorView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/3.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SnapKit //导入SnapKit命名空间


//1.protocol:swift中 没有 '@'
//2.遵守根协议 <NSObject>
//3.如果不遵守 NSObjectProtocol<基协议> 就无法使用 weak 关键字
//4.声明可选的协议方法 需要使用 optional关键字 是 OC中的关键字 需要在声明的协议前 加上 '@objc'
@objc protocol RYVisitorViewDelegate: NSObjectProtocol {
    //协议方法
    optional func userWillRegister()
//    optional func userWillLogin()
    func userWillLogin()
}


class RYVisitorView: UIView {
// MARK: - 声明代理属性
    //声明代理 swift属性 默认的属性关键字 就是 strong
    //声明弱引用的属性 需要 weak
    weak var delegate:RYVisitorViewDelegate?
// MARK: - 代理方法
    @objc private func clickLoginBT () {
        delegate?.userWillLogin()
    }
    @objc private func clicKRegisterBT () {
        delegate?.userWillRegister?()
    }
    
    
    func setVisitorViewWithInfo(imageName:String?,titleText:String) {
        if let img = imageName {
            iv_circleIcon.image = UIImage(named: img)
            iv_bigHouse.hidden = true
            bringSubviewToFront(iv_circleIcon)
        }else {
            //说明在主页
            startCircleAnimation()
        }
        lb_notiText.text = titleText
    }
    
    private func startCircleAnimation () {
        //基础动画
        let baseAni = CABasicAnimation(keyPath: "transform.rotation")
        baseAni.repeatCount = MAXFLOAT
        baseAni.toValue = 2 * M_PI
        baseAni.duration = 10
        //设置动画完成/ 页面失去活跃状态  不移除图层
        baseAni.removedOnCompletion = false
        //添加动画
        iv_circleIcon.layer.addAnimation(baseAni, forKey: nil)
    }
    
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
        //灰度颜色
        self.backgroundColor = UIColor(white: 0.93, alpha: 1)
//        self.backgroundColor = UIColor.whiteColor()
        addSubview(iv_circleIcon)
        //遮住环形
        addSubview(iv_backView)
        
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
            make.height.equalTo(40)
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
        iv_backView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(bt_toRegister.snp_bottom)
        }
// MARK: - 添加监听事件
        bt_toLogin.addTarget(self, action: "clickLoginBT", forControlEvents: .TouchUpInside)
        bt_toRegister.addTarget(self, action: "clicKRegisterBT", forControlEvents: .TouchUpInside)
    }
    
// MARK: - 懒加载控件
    //环形图片
    lazy var iv_circleIcon:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //大房子图片
    lazy var iv_bigHouse:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    //提示文案
    //通过类方法实现
//    lazy var lb_notiText:UILabel = UILabel.label("注册登陆开启新世界的大门哦~", fontSize: 14, textColor: UIColor.darkGrayColor())
    //通过便利构造函数
    lazy var lb_notiText:UILabel = UILabel(text: "注册登陆开启新世界的大门哦~", fontSize: 14, textColor: UIColor.darkGrayColor())

    //登陆按钮
    lazy var bt_toLogin:UIButton = {
        let b = UIButton(backgroundImageName: "common_button_white_disable", titleText: "Login", textFont: 18, textColor: UIColor.darkGrayColor())
        return b
    }()
    //注册按钮
    lazy var bt_toRegister:UIButton = {
        let b = UIButton(backgroundImageName: "common_button_white_disable", titleText: "Register", textFont: 18, textColor: UIColor.orangeColor())
        return b
    }()
    //背景
    lazy var iv_backView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
}
