//
//  RYBottomView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/18.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYBottomView: UIView {
    //MARK: 定义外部变量
    
    //找到自定义的入口
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 设置视图
    private func setupUI() {
        backgroundColor = col_white
        addSubview(bt_retweeted)
        addSubview(bt_like)
        addSubview(bt_comment)
        
        
        //三等分一个视图
        //1.左右都应该设置约束条件
        //2.设置宽度相等
        //设置约束
        bt_retweeted.snp_makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self)
            
        }
        
        bt_comment.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bt_retweeted.snp_right)
            make.bottom.top.equalTo(self)
            make.width.equalTo(bt_retweeted.snp_width)
        }
        bt_like.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bt_comment.snp_right)
            make.bottom.top.equalTo(self)
            make.right.equalTo(self.snp_right)
            make.width.equalTo(bt_comment.snp_width)
        }
        
    }
    
    //MARK: 懒加载子视图
    //转发微博的按钮
    private lazy var bt_retweeted: UIButton = UIButton(backgroundImageName: nil , titleText: "转发", textFont: 10, textColor: col_darkGray, imageName: "timeline_icon_retweet")
    
    // 评论
    private lazy var bt_comment: UIButton = UIButton(backgroundImageName: nil, titleText: "评论", textFont: 10, textColor: col_darkGray, imageName: "timeline_icon_comment")
    //点赞
    private lazy var bt_like: UIButton = UIButton(backgroundImageName: nil , titleText: "赞", textFont: 10, textColor: col_darkGray, imageName: "timeline_icon_unlike")

}
