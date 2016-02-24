//
//  RYEmotionView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = col_orange
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - 懒加载控件
    // MARK: - 懒加载控件
    /// 表情集合视图
    private lazy var cv_EmotionCollection: RYEmotionCollection = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let w = UIScreen.mainScreen().bounds.width / 7
        layout.itemSize = CGSize(width: w, height: w)
        let marginTopBot = (self.bounds.height - 3.0 * w - 40) / 2
        layout.sectionInset = UIEdgeInsets(top: marginTopBot, left: 0, bottom: marginTopBot, right: 0)
        layout.scrollDirection = .Horizontal
//        let testFrame = CGRect(x: 0, y: -scrHeight/3, width: scrWidth, height: scrHeight)
        let cv = RYEmotionCollection(frame: CGRectZero, collectionViewLayout: layout)
        cv.registerClass(RYEmotionCell.self, forCellWithReuseIdentifier: emotionCellReuseID)
        return cv
    }()
    /// 工具栏
    private lazy var tb_toolBar = UIToolbar()
    // item Tag
    private var index = 0
}
// MARK: - 布局键盘
extension RYEmotionView {
    private func setUI () {
        addSubview(cv_EmotionCollection)
        addSubview(tb_toolBar)
        // 2. 自动布局
        tb_toolBar.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(36)
        }
        cv_EmotionCollection.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(tb_toolBar.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
        }
    }
    private func setToolBar () {
        
        tintColor = UIColor.darkGrayColor()
        var tbItems = [UIBarButtonItem]()
        for title in ["最近","默认","emoji","浪小花"] {
            let item = UIBarButtonItem(title: title, style: .Plain, target: self, action: "clickItem:")
            item.tag = index++
            tbItems.append(item)
            //家弹簧
            tbItems.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
        }
        tbItems.removeLast()
        tb_toolBar.items = tbItems
    }
    //通过判断item的tag来实现不同的效果
    private func clickItem (item:UIBarButtonItem?) {
        print(item?.tag)
    }
}


