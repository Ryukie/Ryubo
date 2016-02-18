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
    var status : RYStatus?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setAutoLayoutForSubViews()
    }
    
    private lazy var lb_UPerName : UILabel = UILabel(text: "上铺老王", fontSize: 14, textColor: UIColor.darkGrayColor())
}
// MARK: - 设置子控件
extension RYOriginalWeibo {
    
    private func setUpSubView () {
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addSubview(lb_UPerName)
    }
    private func setAutoLayoutForSubViews () {
        lb_UPerName.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp_left)
            make.width.equalTo(100)
        }
    }
}