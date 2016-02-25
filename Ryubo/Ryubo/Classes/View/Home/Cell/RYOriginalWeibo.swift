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
            setPicView()
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
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    //转发视图
    private lazy var v_retweet:RYRetweetView = RYRetweetView()
    private lazy var picsView : RYPicsView = RYPicsView()
    var cons : Constraint?
}


// MARK: - 布局子控件
extension RYOriginalWeibo {
    private func initUI () {
        self.backgroundColor = col_white95Gray
        addSubview(iv_headIcon)
        addSubview(iv_mbRank)
        addSubview(iv_verified)
        addSubview(lb_content)
        lb_content.preferredMaxLayoutWidth = scrWidth - 2*margin
        lb_content.textAlignment = .Left
        addSubview(lb_name)
        addSubview(lb_source)
        addSubview(lb_time)
        addSubview(picsView)
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
        picsView.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(iv_headIcon.snp_left)
            make.top.equalTo(lb_content.snp_bottom).offset(margin)
        })
        
// MARK: - 设置自动设置行高
        self.snp_updateConstraints { (make) -> Void in
            cons =  make.bottom.equalTo(picsView.snp_bottom).offset(margin).constraint
        }
    }

    private func setPicView () {
        cons?.uninstall()
        picsView.picURLs = status?.picURLs//这里会自动计算一下picView的尺寸 没有的话就是0
        //imURL 不为空   且   count 不为 0
        // imURLS 永远不为空    没有的话会给一个 空数组
        // 如果之判定  count 是否为空的话   没有配图的视图的count的话
//            if status!.picURLs!.count != 0 {
        if ( picsView.picURLs != nil && picsView.picURLs?.count != 0 )  {
//        if let imURLs = status?.picURLs where imURLs.count != 0 {
            //加载配图视图
            picsView.backgroundColor = col_white95Gray

            self.snp_updateConstraints { (make) -> Void in
                cons =  make.bottom.equalTo(picsView.snp_bottom).offset(margin).constraint
            }
        } else {
            self.snp_updateConstraints { (make) -> Void in
                cons =  make.bottom.equalTo(lb_content.snp_bottom).offset(margin).constraint
            }
        }
    }
}