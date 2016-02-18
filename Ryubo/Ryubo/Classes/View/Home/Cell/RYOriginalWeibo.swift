//
//  RYOriginalWeibo.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/18.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SnapKit

class RYOriginalWeibo: UIView {

    //weibo数据模型
    var status : RYStatus? {
        didSet {
            iv_headIcon.sd_setImageWithURL(status?.user?.headImageURL, placeholderImage: UIImage(named: "avatar_default_big"))
            lb_name.text = status?.user?.name
            iv_mbRank.image = status?.user?.mbrank_image
            iv_verified.image = status?.user?.verified_type_image
            lb_time.text = status?.created_at
            lb_source.text = status?.source
            lb_content.text = status?.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    //懒加载所有的子视图
    private lazy var iv_headIcon: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var lb_name: UILabel = UILabel(text: "上铺老王", fontSize: 14, textColor: col_orange)
    //用户等级
    private lazy var iv_mbRank: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    //微博时间
    private lazy var lb_time:UILabel = UILabel(text: "22:22", fontSize: 10, textColor: UIColor.lightGrayColor())
    
    //微博来源
    private lazy var lb_source:UILabel = UILabel(text: "摔坏一角的iPhone7sPlus", fontSize: 10, textColor: UIColor.lightGrayColor())
    //微博认证类型
    private lazy var iv_verified: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    //微博正文
    private lazy var lb_content:UILabel = UILabel(text: "你成功的引起了我的注意", fontSize: 14, textColor: UIColor.darkGrayColor())
}


// MARK: - 布局子控件
extension RYOriginalWeibo {
    
    private func setUpSubView () {
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addSubview(iv_headIcon)
        addSubview(iv_mbRank)
        addSubview(iv_verified)
        addSubview(lb_content)
        lb_content.preferredMaxLayoutWidth = scrWidth - 2*margin
        lb_content.textAlignment = .Left
        addSubview(lb_name)
        addSubview(lb_source)
        addSubview(lb_time)
        
        //设置约束
        iv_headIcon.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(margin)
            make.left.equalTo(self.snp_left).offset(margin)
            make.size.equalTo(CGSize(width: 35, height: 35))
            
        }
        
        lb_name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iv_headIcon.snp_top)
            make.left.equalTo(iv_headIcon.snp_right).offset(margin)
        }
        
        iv_mbRank.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(lb_name.snp_top)
            make.left.equalTo(lb_name.snp_right).offset(margin)
        }
        
        lb_time.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iv_headIcon.snp_right).offset(margin)
            make.bottom.equalTo(iv_headIcon.snp_bottom)
            
        }
        
        lb_source.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(lb_time.snp_right).offset(margin)
            make.bottom.equalTo(lb_time.snp_bottom)
        }
        
        iv_verified.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iv_headIcon.snp_right)
            make.centerY.equalTo(iv_headIcon.snp_bottom)
        }
        
        lb_content.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iv_headIcon.snp_left)
            make.top.equalTo(iv_headIcon.snp_bottom).offset(margin)
        }
        
// MARK: - 设置自动设置行高
        //设置一个非常关键的属性 就可以实现 自动设置VIew高度
        self.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(lb_content.snp_bottom).offset(margin)
        }
        
    }
}