//
//  RYEmotionCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
// MARK: - 懒加载控件
    lazy var bt_emotion : UIButton = UIButton()
}
// MARK: - 布局子空间
extension RYEmotionCell {
    private func setUI () {
        addSubview(bt_emotion)
//        bt_emotion.backgroundColor = col_white
        bt_emotion.setTitleColor(col_darkGray, forState: .Normal)
        //  ????????????
        bt_emotion.frame = CGRectInset(bounds, 4, 4)
    }
}