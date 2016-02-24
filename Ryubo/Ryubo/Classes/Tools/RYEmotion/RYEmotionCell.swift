//
//  RYEmotionCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionCell: UICollectionViewCell {
    /// 表情符号
    var emotion: RYEmotionModel? {
        didSet {
            bt_emotion.setImage(UIImage(named: emotion!.imagePath! ?? ""), forState: .Normal)
            bt_emotion.setTitle(emotion?.emoji ?? "", forState: .Normal)
            
            // 是否删除按钮
            if emotion!.isRemoved {
                bt_emotion.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
            }
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bt_emotion.titleLabel?.font = UIFont.systemFontOfSize(32)
        bt_emotion.userInteractionEnabled = false
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