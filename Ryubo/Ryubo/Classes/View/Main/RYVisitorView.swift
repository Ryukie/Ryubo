//
//  RYVisitorView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/3.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYVisitorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    //默认实现报错
    //当程序员通过 sb / xib 加载该视图 程序就会崩溃
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadUI () {
        self.backgroundColor = UIColor.redColor()
    }

}
