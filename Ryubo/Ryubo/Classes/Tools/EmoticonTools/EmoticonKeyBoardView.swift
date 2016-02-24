//
//  EmoticonKeyBoardView.swift
//  EmoticonKeyboard
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

//闭包不会立即执行 需要等待用户操作 才能够执行

//不需要导入命名空间
private let EmoticonCellId = "EmoticonCellId"
private let emoticonCellMargin: CGFloat = 5
private let rowCount: CGFloat = 7
private let toolBarHeight: CGFloat = 35


class EmoticonKeyBoardView: UIView {

    //MARK: 定义外部变量
    private lazy var packages = EmoticonManager().packages
    
    var selectEmoticon: ((em: Emoticon) -> ())?
    
    @objc private func itemDidClick(item: UIBarButtonItem) {
        print(item.tag)
        //滚动 集合视图
        let indexPath = NSIndexPath(forItem: 0, inSection: item.tag)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
    }
    
    
    
    //找到自定义的入口
    init(selectEmoticon: (em: Emoticon) -> ()) {
        self.selectEmoticon = selectEmoticon
        //指定默认的大小
        //系统键盘的默认高度是多少?  216 iPhone 6+/6s+:系统键盘的高度: 226
        let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 220)
        super.init(frame: rect)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 设置视图
    private func setupUI() {
        addSubview(collectionView)
        addSubview(toolBar)
        
        
        
        //设置约束
        
        collectionView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            ///底部相对于toolbar  不能够在这个时候添加底部约束 因为tool还没有添加约束呢
        }
        
        
        //设置toolbar
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            //指定高度
            make.height.equalTo(toolBarHeight)
            //指定顶部约束
            make.top.equalTo(collectionView.snp_bottom)
        }
        
        
        //设置控件
        setToolbar()
        
    }
    
    //MARK: 懒加载子视图
    private lazy var collectionView: UICollectionView = {
        
        //获取layout对象
        let layout = UICollectionViewFlowLayout()
        //设置layout
        //1.滚动方向
        layout.scrollDirection = .Horizontal
        //设置itemSize
        let w = UIScreen.mainScreen().bounds.width / rowCount
        layout.itemSize = CGSize(width: w, height: w)
        //设置间距
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        //平均垂直方法的间距
        let padding = (self.bounds.height - toolBarHeight - 3 * w) / 4
        
        layout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        
        let cv = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        //注册Cell
        cv.registerClass(EmoticonCell.self, forCellWithReuseIdentifier: EmoticonCellId)
        
        //设置数据源代理
        cv.dataSource = self
        //指定代理
        cv.delegate = self
        //设置分页滚动
        cv.pagingEnabled = true
        //设置颜色
        cv.backgroundColor = UIColor.whiteColor()
        
        return cv
    }()
    
    
    private lazy var toolBar: UIToolbar = UIToolbar()

    
    
}

extension EmoticonKeyBoardView: UICollectionViewDataSource, UICollectionViewDelegate {
    //实现数据源方法 
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return packages.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //在iOS 一个可以交互的控件原则上 大小 不能小于 40
        return packages[section].emoticons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonCellId, forIndexPath: indexPath) as! EmoticonCell
        
        //设置调试颜色
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.greenColor()
//        cell.str = "\(indexPath.section) + \(indexPath.row)"
        cell.emoticon = packages[indexPath.section].emoticons[indexPath.row]
        return cell
    }
    
    
    //点击cell的协议方法
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //获取表情模型
        let em = packages[indexPath.section].emoticons[indexPath.row]
        //1.没有智能提示 这个就不要等智能提示 给自己加上可选项的 '?'
        //2. 加 '.'
        //3: 删 '.'
        selectEmoticon?(em: em)
    }
    
    
}

//-----------------------------自定义cell------------------------------
class EmoticonCell: UICollectionViewCell {
    //MARK: 定义外部变量
    
    
    var emoticon: Emoticon? {
        didSet {
//            emotionBtn.setTitle(emoticon?.chs ?? "", forState: .Normal)
            //bundle路径下的图片 必须使用绝对路径
            print(emoticon?.imagePath)
            emotionBtn.setImage(UIImage(contentsOfFile: emoticon?.imagePath ?? ""), forState: .Normal)
            //emoji 本身就是字符串
            emotionBtn.setTitle(emoticon?.emojiStr ?? "", forState: .Normal)
            if let em = emoticon where em.isDelete {
                //设置删除按钮
                emotionBtn.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
            }
        }
    }
    //找到自定义的入口
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 设置视图
    private func setupUI() {
        
        //设置按钮的不可交互
        emotionBtn.userInteractionEnabled = false
        contentView.addSubview(emotionBtn)
        emotionBtn.titleLabel?.font = UIFont.systemFontOfSize(32)
        //设置约束
        emotionBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
    }
    
    //MARK: 懒加载子视图
    private lazy var emotionBtn: UIButton = UIButton()
}


//设置UI
extension EmoticonKeyBoardView {
    private func setToolbar() {
        //设置颜色 
        toolBar.tintColor = UIColor.darkGrayColor()
    
        var items = [UIBarButtonItem]()
        
        //定义索引
        var index = 0
        //向数组中添加item
        for p in packages {
            
            //添加弹簧
            let space1 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            items.append(space1)
            
            let item = UIBarButtonItem(title: p.group_name_cn, style: .Plain, target: self, action: "itemDidClick:")
            //添加到数组中
            items.append(item)
            item.tag = index++
            
            //添加弹簧
            let space2 = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            items.append(space2)
        }
        
        toolBar.items = items
    }
}
