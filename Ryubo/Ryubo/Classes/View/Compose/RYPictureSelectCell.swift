//
//  RYPictureSelectCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/23.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

protocol RYPictureSelectCellDelegate : NSObjectProtocol {
    func addPic (sender: RYPictureSelectCell?)
    func delectPci (sender: RYPictureSelectCell?)
}

class RYPictureSelectCell: UICollectionViewCell {
    var image : UIImage? {
        didSet {
            if image == nil {
                image = UIImage(named: "compose_pic_add")
                bt_picAdd.setImage(image, forState: .Normal)
                bt_picAdd.setImage(image, forState: .Highlighted)
//                isPicAdded = false
            }
            bt_picAdd.setImage(image, forState: .Normal)
//            isPicAdded = true
        }
    }
    var isPicAdded = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - 懒加载子控件
    private lazy var bt_picAdd : UIButton = UIButton(backgroundImageName: nil, imageName: "compose_pic_add")
    private lazy var bt_picDelete : UIButton = UIButton(backgroundImageName: nil, imageName: "compose_photo_close")
    //设置代理属性
    weak var cellDelegate : RYPictureSelectCellDelegate?
}

// MARK: - 布局子控件
extension RYPictureSelectCell {
    private func setUI () {
        contentView.addSubview(bt_picAdd)
        contentView.addSubview(bt_picDelete)
        bt_picAdd.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView)
        }
        bt_picDelete.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(contentView)
        }
        bt_picAdd.addTarget(self, action: "clickAddPicBtn", forControlEvents: .TouchUpInside)
        bt_picDelete.addTarget(self, action: "clickDelectPciBtn", forControlEvents: .TouchUpInside)
    }
    @objc private func clickAddPicBtn () {
        cellDelegate?.addPic(self)
    }
    @objc private func clickDelectPciBtn () {
        cellDelegate?.delectPci(self)
    }
}