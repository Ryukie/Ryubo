//
//  RYRetweetView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYRetweetView: UIView {
    var status : RYStatus? {
        didSet {
            lb_test.text = status?.retweeted_status?.text
            setupUI()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        addSubview(lb_test)
        lb_test.textAlignment = .Left
        lb_test.preferredMaxLayoutWidth = scrWidth - 2*margin
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var lb_test:UILabel = UILabel(text: "转发微博", fontSize: 14, textColor: col_darkGray)
    private func setupUI () {
        lb_test.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(margin)
            make.left.equalTo(self.snp_left).offset(margin)
        }
        self.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(lb_test.snp_bottom).offset(margin)
        }
    }
}
