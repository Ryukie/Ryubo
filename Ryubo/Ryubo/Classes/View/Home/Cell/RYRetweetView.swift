//
//  RYRetweetView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/20.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SnapKit

class RYRetweetView: UIView {
    var status : RYStatus? {
        didSet {
            setUI()
            lb_test.text = status?.text
            lb_test.textAlignment = .Left
            lb_test.preferredMaxLayoutWidth = scrWidth - 2*margin
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        initUI()
    }
    private func initUI () {
        addSubview(lb_test)
        //设置约束
        lb_test.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(margin)
            make.left.equalTo(self.snp_left).offset(margin)
        }
        //设置底部约束相对于配图视图的底部
        self.snp_makeConstraints(closure: { (make) -> Void in
            con = make.bottom.equalTo(lb_test.snp_bottom).offset(margin).constraint
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //配图视图
    private func setUI () {
        //更新约束
        con?.uninstall()
        if status?.picURLs?.count != 0 {
            addSubview(picsView)
            picsView.backgroundColor = col_retweetCol
            picsView.picURLs = status?.picURLs
            picsView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(lb_test.snp_bottom).offset(margin)
                make.left.equalTo(lb_test.snp_left)
            })
            self.snp_updateConstraints(closure: { (make) -> Void in
                con = make.bottom.equalTo(picsView.snp_bottom).offset(margin).constraint
            })
        } else {
            self.snp_updateConstraints(closure: { (make) -> Void in
                con = make.bottom.equalTo(lb_test.snp_bottom).offset(margin).constraint
            })
        }
    }
    var con : Constraint?
    private lazy var picsView : RYPicsView = RYPicsView()
    private var lb_test:UILabel = UILabel(text: "转发微博", fontSize: 14, textColor: col_darkGray)
}
