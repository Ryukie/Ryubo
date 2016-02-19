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
            //根据图片个数决定有多少个imageView
            if picURLs?.count != 0 {
                for item in picURLs! {
                    let iv = creatAImageView(item)
                    ivs_pic?.append(iv)
                }
            }
            layoutImageViews()
            self.reloadData()
        }
    }
    private var ivs_pic : [UIImageView]?
    private func creatAImageView (picURL:NSURL) -> UIImageView {
        let iv = UIImageView()
        return iv
    }
    private var flowLayout : UICollectionViewFlowLayout?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        flowLayout = UICollectionViewFlowLayout()//一定要有个非空的布局对象
        flowLayout!.minimumInteritemSpacing = picCellMargin
        flowLayout!.minimumLineSpacing = picCellMargin
        let insert = UIEdgeInsets(top: picCellMargin, left: picCellMargin, bottom: picCellMargin, right: picCellMargin)
        flowLayout?.sectionInset = insert
//        flowLayout!.itemSize = CGSizeZero
        super.init(frame: frame, collectionViewLayout: flowLayout!)
        scrollEnabled = false
        backgroundColor = col_white95Gray
        dataSource = self
        
        registerClass(RYPictureCell.self, forCellWithReuseIdentifier: itemID)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - 布局子空间
extension RYPicsView {
    private func layoutImageViews () {
        //根据图片数量决定使用何种图片布局
        // 1 -> 等比例"全屏"
        // 2~4 -> 四宫格
        // 5~9 -> 九宫格
//        print(picURLs?.count)
        if picURLs?.count == 1 {
            setOnePicView()
//            setNinePicView()
        }
        if (picURLs?.count>=2 && picURLs?.count<=4) {
            setFourPicView()
//            setNinePicView()
        }
        if (picURLs?.count>=5 && picURLs?.count<=9) {
            setNinePicView()
        }
    }
    private func setOnePicView () {
//        print(__FUNCTION__)
        flowLayout!.itemSize = CGSizeMake(180, 120)//长 < 宽
//        flowLayout?.itemSize = CGSizeMake(120, 180)//长 < 宽
    }
    private func setFourPicView () {
//        print(__FUNCTION__)
        let width = (scrWidth - picCellMargin*3)/2
        flowLayout!.itemSize = CGSizeMake(width,width)
    }
    private func setNinePicView () {
//        print(__FUNCTION__)
        let width = (scrWidth - picCellMargin*4)/3
        flowLayout!.itemSize = CGSizeMake(width, width)
    }
    
}
// MARK: - 数据源方法
extension RYPicsView:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(itemID, forIndexPath: indexPath) as! RYPictureCell
        item.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return item
    }
    
}

