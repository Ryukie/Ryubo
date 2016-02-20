//
//  RYRetweetHeader.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYRetweetHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = col_darkGray
        addSubview(lb_text)
        lb_text.textAlignment = .Left
        lb_text.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(5)
            make.left.equalTo(self.snp_left).offset(5)
            make.width.equalTo(scrWidth-5)
        }
        self.snp_prepareConstraints { (make) -> Void in
            make.bottom.equalTo(lb_text.snp_bottom)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var lb_text = UILabel(text: "撒娇把河北土豪分个人普通级不知道权威了空间和犹太人割发代首表面那么你们还能够尽快来发个帖", fontSize: 14, textColor: col_white)
}
