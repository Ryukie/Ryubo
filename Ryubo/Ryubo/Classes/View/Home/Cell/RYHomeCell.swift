//
//  RYHomeCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/17.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYHomeCell: UITableViewCell {
    var status : RYStatus? {
        didSet {
            //一旦设置了微博数据模型就为View赋值
//            print(status)
            originalWeiboView.status = status
            if status?.pic_urls?.count != 0 {
                picsView.picURLs = status?.picURLs
            }
        }
    }
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        setUpSubviews()
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
}
// MARK: - 界面设置
extension RYHomeCell {
    // MARK: - 添加子控件
    private func setUpSubviews () {
        self.backgroundColor = UIColor.blueColor()
        contentView.addSubview(originalWeiboView)
        //判断是否存在微博配图
        if status?.picURLs?.count != 0 {
            //加载配图视图
            contentView.addSubview(picsView)
            //设置自动布局
            picsView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.equalTo(contentView)
                make.top.equalTo(originalWeiboView.snp_bottom)
                make.height.equalTo(100)
            })
        }
        
        contentView.addSubview(bottomView)
        
        originalWeiboView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
        }
        
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(contentView)
            if status?.picURLs?.count == 0 {
                make.top.equalTo(originalWeiboView.snp_bottom)
            } else {
                make.top.equalTo(picsView.snp_bottom)
            }
            make.height.equalTo(35)
        }
        //给contenView设置约束条件
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
//        self.layoutIfNeeded()
    }
    
}
