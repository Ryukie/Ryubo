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
        let insert = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout?.sectionInset = insert
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
//========================================================
// MARK: - 布局子控件
extension RYPicsView {
    private func layoutImageViews () {
        //根据图片数量决定使用何种图片布局
        // 1 -> 等比例"全屏"
        // 2~4 -> 四宫格
        // 5~9 -> 九宫格
        let num  = picURLs?.count ?? 0
        if num == 1 {
            setOnePicView()
            return
        }
        if num == 4 {
            setFourPicView()
            return
        }
        let width = (scrWidth - picCellMargin*4)/3
        let row = CGFloat((num-1)/3 + 1)
        flowLayout!.itemSize = CGSize(width:width, height: width)
        self.snp_updateConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: scrWidth, height: width*row + picCellMargin*(row-1)))
        }
        
    }
    private func setOnePicView () {
        flowLayout!.itemSize = CGSize(width:180, height: 120)//长 < 宽
        self.snp_updateConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: scrWidth, height: 120))
        }
    }
    private func setFourPicView () {
        let width = (scrWidth - picCellMargin*3)/2
        flowLayout!.itemSize = CGSize(width:width, height: width)
        self.snp_updateConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: scrWidth, height: width*2 + picCellMargin*3))
        }
    }
    private func setNinePicView () {
    }
}
//========================================================
// MARK: - 数据源方法
extension RYPicsView:UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picURLs?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCellWithReuseIdentifier(itemID, forIndexPath: indexPath) as! RYPictureCell
        item.backgroundColor = UIColor(white: 0.95, alpha: 1)
        item.imageURL = picURLs![indexPath.item]
        return item
    }
}

