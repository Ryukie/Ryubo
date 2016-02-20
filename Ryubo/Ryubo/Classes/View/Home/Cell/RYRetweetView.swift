//
//  RYRetweetView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYRetweetView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = col_orange
        addSubview(lb_test)
        lb_test.textAlignment = .Left
        lb_test.preferredMaxLayoutWidth = scrWidth - 2*margin
        lb_test.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(margin)
            make.left.equalTo(self.snp_left).offset(margin)
        }
        self.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(lb_test.snp_bottom).offset(margin)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var lb_test:UILabel = UILabel(text: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈你男男女女男男女女男男女女们么么么么么么么么顶顶顶顶顶大大大", fontSize: 14, textColor: col_darkGray)
}
