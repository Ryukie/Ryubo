//
//  RYEmotionCollection.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

/*
每一个 cell 上放置一个表情按钮
每个页面显示20个表情
最后一个 cell 显示删除按钮
*/

class RYEmotionCollection: UICollectionView,UICollectionViewDataSource {
    //reuseID
    
    var eLayout = UICollectionViewFlowLayout()
}
// MARK: - dataSourceFunc
extension RYEmotionCollection {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emotionCellReuseID, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }

}