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
            layoutItems()
            self.reloadData()
        }
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        flowLayout = UICollectionViewFlowLayout()//一定要有个非空的布局对象
        flowLayout!.minimumInteritemSpacing = picCellMargin
        flowLayout!.minimumLineSpacing = picCellMargin
//        let insert = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)
//        flowLayout?.sectionInset = insert
        super.init(frame: frame, collectionViewLayout: flowLayout!)
        scrollEnabled = false
        dataSource = self
        registerClass(RYPictureCell.self, forCellWithReuseIdentifier: itemID)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var flowLayout : UICollectionViewFlowLayout?
}
//========================================================
// MARK: - 布局子控件
extension RYPicsView {
    private func layoutItems () {
        //根据图片数量决定使用何种图片布局
        let num  = picURLs?.count ?? 0
        //没有配图视图
        if num == 0 {
            self.snp_updateConstraints { (make) -> Void in
                make.size.equalTo(CGSizeZero)
            }
            return
        }
        if num == 1 {
            setOnePicView()
            return
        }
        if num == 4 {
            setFourPicView()
            return
        }
        let width = (scrWidth - picCellMargin*2 - margin*2)/3
        let row = CGFloat((num-1)/3 + 1)
        flowLayout!.itemSize = CGSize(width:width, height: width)
        self.snp_updateConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: width*3 + 2*picCellMargin, height: width*row + picCellMargin*(row-1)))
        }
    }
    private func setOnePicView () {
        flowLayout!.itemSize = CGSize(width:180, height: 120)//长 < 宽
        self.snp_updateConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 180, height: 120))
        }
    }
    private func setFourPicView () {
        let width = (scrWidth*0.681 - picCellMargin - margin*2)/2
        flowLayout!.itemSize = CGSize(width:width, height: width)
        self.snp_updateConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 2*width + picCellMargin, height: width*2 + picCellMargin))
        }
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

