//
//  RYPictureCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/19.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SDWebImage

class RYPictureCell: UICollectionViewCell {
    var imageURL: NSURL? {
        didSet {
            //设置url
            iconView.sd_setImageWithURL(imageURL)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - 懒加载图片
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        //视图内容显示模式 默认显示 是 ContentModeScaleToFill   ==> 缩放进行填充  比例一致的图片使用这种样式显示
        //.ScaleAspectFit 图片显示上下可能会留白  基本不会使用这样显示样式
        //ScaleAspectFill 视图会被剪裁  但是 图片显示不会失真  并且不会留白
        iv.contentMode = .ScaleAspectFill
        //手写代码 不会自动设置剪裁
        iv.clipsToBounds = true
        return iv
    }()
//MARK: 设置视图
    private func setupUI() {
        contentView.addSubview(iconView)
        //        iconView.image = UIImage(named: "Brave Shine")
        //设置约束
        iconView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
        
    }
}
