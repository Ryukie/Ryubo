//
//  RYPicsView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/19.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYPicsView: UICollectionView {
    private let itemID = "picView"
    var picURLs : [NSURL]? {
        didSet {
            picNum = picURLs?.count
            //根据图片个数决定有多少个imageView
            if picNum != 0 {
                for item in picURLs! {
//                    print(item)
                    let iv = creatAImageView(item)
                    ivs_pic?.append(iv)
                }
            }
        }
    }
    private var ivs_pic : [UIImageView]?
    private func creatAImageView (picURL:NSURL) -> UIImageView {
        let iv = UIImageView()
        return iv
    }
    private var picNum : NSNumber?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()//一定要有个非空的布局对象
        layout.minimumInteritemSpacing = picCellMargin
        layout.minimumLineSpacing = picCellMargin
        layout.itemSize = CGSizeMake(50, 50)
        super.init(frame: frame, collectionViewLayout: layout)
        scrollEnabled = false
        backgroundColor = col_orange
        layoutImageViews()
        dataSource = self
        
        registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: itemID)
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = col_orange
//        layoutImageViews()
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - 懒加载控件
    
    
    
}
// MARK: - 布局子空间
extension RYPicsView {
    private func layoutImageViews () {
        //根据图片数量决定使用何种图片布局
        // 1 -> 等比例"全屏"
        // 2~4 -> 四宫格
        // 5~9 -> 九宫格
        if picNum == 1 {
            setOnePicView()
        }
        if (picNum?.intValue>=2 || picNum?.intValue<=4) {
            setFourPicView()
        }
        if (picNum?.intValue>=5 || picNum?.intValue<=9) {
            setNinePicView()
        }
        
    }
    private func setOnePicView () {
        print(__FUNCTION__)
    }
    private func setFourPicView () {
        print(__FUNCTION__)
    }
    private func setNinePicView () {
        print(__FUNCTION__)
    }
    
}
// MARK: - 数据源方法
extension RYPicsView:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picNum?.integerValue ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(itemID, forIndexPath: indexPath)
        item.backgroundColor = col_darkGray
        return item
    }
    
}

