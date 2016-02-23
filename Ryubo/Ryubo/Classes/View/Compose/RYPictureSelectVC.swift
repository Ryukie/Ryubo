//
//  RYPictureSelectVC.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/23.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

private let reuseIdentifier = "picSelect"

class RYPictureSelectVC: UICollectionViewController {

    init () {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = margin/2
        layout.minimumLineSpacing = margin/2
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let itemW:CGFloat = (scrWidth-4*margin/2)/3
        layout.itemSize = CGSize(width: itemW, height: itemW)
        super.init(collectionViewLayout: layout)
    }
    
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = margin/2
//        layout.minimumLineSpacing = margin/2
//        let itemW:CGFloat = (scrWidth-4*margin/2)/3
//        layout.itemSize = CGSize(width: itemW, height: itemW)
//        super.init(collectionViewLayout: layout)
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.randomColor()
        self.collectionView!.registerClass(RYPictureSelectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "popPicView")
    }
    @objc private func popPicView () {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private lazy var images = [UIImage]()
}

// MARK: - 实现代理方法 
extension RYPictureSelectVC:RYPictureSelectCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func addPic () {
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            print("访问相册失败")
            return
        }
        let picPicker = UIImagePickerController()
        picPicker.delegate = self
        presentViewController(picPicker, animated: true, completion: nil)
    }
    func delectPci (sender : RYPictureSelectCell?) {
//        print(__FUNCTION__)
        let index = (sender?.tag)! - 100
        if images.count != 0 {
            images.removeAtIndex(index)
            collectionView?.reloadData()
        }
    }
    
//    //选择器的代理方法
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        //编辑信息
//        print(editingInfo)
//        //将图片加入图片数组
//        images.append(image)
//        //2.刷新页面
//        collectionView?.reloadData()
//        //一旦我们实现了这个方法 我们就的自己dismiss
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    //最好用下面的代替  iOS 2.0 以后
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        print(info)
        //帮助文档中有各个键值的说明
        let img = info["UIImagePickerControllerOriginalImage"] as! UIImage
        images.append(img)
        collectionView?.reloadData()
//        print(img)
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - dataSource
extension RYPictureSelectVC {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count+1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RYPictureSelectCell
        cell.backgroundColor=col_darkGray
        cell.cellDelegate = self
        cell.tag = indexPath.row + 100
        if indexPath.row == images.count {
            cell.image = nil
        }else {
            cell.image = images[indexPath.row]
        }
        
        return cell
    }
}