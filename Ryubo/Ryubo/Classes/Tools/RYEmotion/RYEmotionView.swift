//
//  RYEmotionView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/24.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYEmotionView: UIView {
    
    /// 选中表情回调函数
    private var selectedEmoticonCallBack: (emoticon: RYEmotionModel) -> ()
    
    // MARK: - 构造函数
    init(selectedEmoticon: (emoticon: RYEmotionModel) -> ()) {
        self.selectedEmoticonCallBack = selectedEmoticon
        var rect = UIScreen.mainScreen().bounds
        rect.size.height = 216
        super.init(frame: rect)
        // 设置控件
        self.setUI()
        // 跳转到默认分组
        let indexPath = NSIndexPath(forItem: 0, inSection: 1)
        dispatch_async(dispatch_get_main_queue()) {
            self.cv_EmotionCollection.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
        }
    }
    
//    override init(frame: CGRect) {
//        let f = CGRectMake(0, 0, scrHeight, scrHeight)
//        super.init(frame: f)
//        backgroundColor = col_orange
//        setUI()
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - 懒加载控件
    // MARK: - 懒加载控件
    /// 表情集合视图
    private lazy var cv_EmotionCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let w = UIScreen.mainScreen().bounds.width / 7
        layout.itemSize = CGSize(width: w, height: w)
        let marginTopBot = (self.bounds.height - 3.0 * w - 40) / 2
        layout.sectionInset = UIEdgeInsets(top: marginTopBot, left: 0, bottom: marginTopBot, right: 0)
        layout.scrollDirection = .Horizontal
        let testFrame = CGRect(x: 0, y: 0, width: scrWidth, height: scrHeight)
//        let cv = RYEmotionCollection(frame: CGRectZero, collectionViewLayout: layout)
        let cv = UICollectionView(frame: testFrame, collectionViewLayout: layout)
        cv.registerClass(RYEmotionCell.self, forCellWithReuseIdentifier: emotionCellReuseID)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    /// 工具栏
    private lazy var tb_toolBar = UIToolbar()
    // item Tag
    private var index = 0
    /// 表情包数组
    private lazy var packages = RYEmotionViewManager.sharedEmotionManager.packages
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
        for package in packages {
            let item = UIBarButtonItem(title: package.group_name_cn, style: .Plain, target: self, action: "clickItem:")
            item.tag = index++
            tbItems.append(item)
            //家弹簧
            tbItems.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
        }
        tbItems.removeLast()
        tb_toolBar.items = tbItems
    }
    //通过判断item的tag来实现   点击切换  section  到起始位置
    private func clickItem (item:UIBarButtonItem?) {
        print(item?.tag)
        let indexPath = NSIndexPath(forItem: 0, inSection: item!.tag)
        cv_EmotionCollection.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
        
//        // 跳转到默认分组
//        let indexPath = NSIndexPath(forItem: 0, inSection: 1)
//        dispatch_async(dispatch_get_main_queue()) {
//            self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
//        }
//        
    }
}
extension RYEmotionView : UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return packages.count
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].emotions.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emotionCellReuseID, forIndexPath: indexPath) as! RYEmotionCell
        //        cell.backgroundColor = UIColor.randomColor()
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.greenColor()
        cell.bt_emotion.setTitle("\(indexPath.item)", forState: .Normal)
        cell.emotion = packages[indexPath.section].emotions[indexPath.item]
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let em = packages[indexPath.section].emotions[indexPath.item]
        selectedEmoticonCallBack(emoticon: em)
    }
}

