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
            originalWeiboView.status = status
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
}
// MARK: - 界面设置
extension RYHomeCell {
    // MARK: - 添加子控件
    private func setUpSubviews () {
        self.backgroundColor = UIColor.blueColor()
        //加载原创微博的view
        contentView.addSubview(originalWeiboView)
        contentView.addSubview(bottomView)
        originalWeiboView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
        }
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(contentView)
            make.top.equalTo(originalWeiboView.snp_bottom)
            make.height.equalTo(35)
        }
        //给contenView设置约束条件
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
    }
}
