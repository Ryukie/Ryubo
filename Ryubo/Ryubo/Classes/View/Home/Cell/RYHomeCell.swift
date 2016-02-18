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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpSubviews()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    //原创微博使用的view
   private lazy var originalWeiboView : RYOriginalWeibo = RYOriginalWeibo()
}
// MARK: - 界面设置
extension RYHomeCell {
    // MARK: - 添加子控件
    private func setUpSubviews () {
        self.backgroundColor = UIColor.blueColor()
        //加载原创微博的view
        contentView.addSubview(originalWeiboView)
        
        originalWeiboView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(margin)
            make.left.right.equalTo(self)
            make.height.equalTo(80)
        }
    }

    
}
