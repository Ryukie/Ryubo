//
//  RYHomeCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/17.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SnapKit

class RYHomeCell: UITableViewCell {
    var bottomViewTopCon : Constraint?
    var status : RYStatus? {
        didSet {
            originalWeiboView.status = status
            setUpSubviews()
        }
    }
    private var isOriginalPic:Bool {
        if (status?.pic_urls?.count != 0 ){
            return true
        }else if  (status?.retweeted_status != nil && status?.retweeted_status?.pic_urls?.count != 0) {
            return true
        }
        return false
    }
    
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = col_white95Gray
        contentView.addSubview(originalWeiboView)
        contentView.addSubview(bottomView)
        contentView.addSubview(retweetView)
        originalWeiboView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
        }
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(contentView)
            make.height.equalTo(35)
            bottomViewTopCon = make.top.equalTo(retweetView.snp_bottom).constraint
        }
        retweetView.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(originalWeiboView.snp_bottom)
            make.left.right.equalTo(originalWeiboView)
        })
        
        //给contenView设置约束条件
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    //原创微博使用的view
    private lazy var originalWeiboView : RYOriginalWeibo = RYOriginalWeibo()
    //底部转发评论赞视图
    private lazy var bottomView : RYBottomView = RYBottomView()
    //配图视图
    private lazy var picsView : RYPicsView = RYPicsView()
    private lazy var retweetView : RYRetweetView = RYRetweetView()
}

// MARK: - 界面设置
extension RYHomeCell {
    // MARK: - 添加子控件
    private func setUpSubviews () {
        bottomViewTopCon?.uninstall()
        if status?.retweeted_status != nil  {
//            addSubview(retweetView)
//            contentView.addSubview(retweetView)
            retweetView.status = status?.retweeted_status
            retweetView.backgroundColor = col_retweetCol
            retweetView.hidden = false
//            retweetView.snp_makeConstraints(closure: { (make) -> Void in
//                make.top.equalTo(originalWeiboView.snp_bottom)
//                make.left.right.equalTo(originalWeiboView)
//            })
            bottomView.snp_updateConstraints(closure: { (make) -> Void in
                bottomViewTopCon =  make.top.equalTo(retweetView.snp_bottom).constraint
            })
        }else {
            retweetView.hidden = true
            bottomView.snp_updateConstraints { (make) -> Void in
                bottomViewTopCon = make.top.equalTo(originalWeiboView.snp_bottom).constraint
            }
        }
    }
}
