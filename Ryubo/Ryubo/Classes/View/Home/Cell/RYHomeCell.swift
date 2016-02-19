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
            
            setUpSubviews()
            
            //一旦设置了微博数据模型就为View赋值
            originalWeiboView.status = status
//            print(__FUNCTION__)
            if status?.pic_urls?.count != 0 {
                picsView.picURLs = status?.picURLs
            }
        }
    }
    private var isOriginalPic:Bool {
//        print(__FUNCTION__)
        if status?.pic_urls?.count != 0 {
            return true
        }
        return false
    }
    
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setUpSubviews()
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
        
//        print(isOriginalPic)
        
        self.backgroundColor = UIColor.blueColor()
        contentView.addSubview(originalWeiboView)
        //判断是否存在原创微博配图
        //加载配图视图
        contentView.addSubview(picsView)
        
        
        contentView.addSubview(bottomView)
        originalWeiboView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(contentView)
        }
        
        
        //不使用更新约束的话  重用的时候会产生多余的约束
        if isOriginalPic==false {
            picsView.snp_remakeConstraints(closure: { (make) -> Void in
                make.left.right.equalTo(contentView)
                make.top.equalTo(originalWeiboView.snp_bottom)
                make.height.equalTo(0)
            })
            
            bottomView.snp_remakeConstraints(closure: { (make) -> Void in
                make.left.right.equalTo(contentView)
                make.height.equalTo(35)
                make.top.equalTo(originalWeiboView.snp_bottom)
            })
        }else {
            picsView.snp_remakeConstraints(closure: { (make) -> Void in
                make.left.right.equalTo(contentView)
                make.top.equalTo(originalWeiboView.snp_bottom)
                make.height.equalTo(500)
            })
            
            bottomView.snp_remakeConstraints { (make) -> Void in
                make.left.right.equalTo(contentView)
                make.height.equalTo(35)
                make.top.equalTo(picsView.snp_bottom)
            }
        }

        //给contenView设置约束条件
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
//        self.layoutIfNeeded()
    }
    
}
