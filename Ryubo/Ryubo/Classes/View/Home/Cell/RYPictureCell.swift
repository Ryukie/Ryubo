//
//  RYPictureCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/19.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYPictureCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = col_darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
