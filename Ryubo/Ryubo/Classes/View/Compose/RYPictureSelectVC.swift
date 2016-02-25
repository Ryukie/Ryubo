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
    //用这个不行
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = margin/2
//        layout.minimumLineSpacing = margin/2
//        let itemW:CGFloat = (scrWidth-4*margin/2)/3
//        layout.itemSize = CGSize(width: itemW, height: itemW)
//        super.init(collectionViewLayout: layout)
//    }
    var changeKeyboard : (() -> Void)?
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.backgroundColor = col_lightGray
        self.collectionView!.registerClass(RYPictureSelectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "popPicView")
    }
    @objc private func popPicView () {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    lazy var images = [UIImage]()
    private var selectCell : RYPictureSelectCell?
    // 设置最大图片数量
    private let maxPicNum = 9
    // 是否显示
    var isShowed : Bool = false
}

// MARK: - 实现代理方法 
extension RYPictureSelectVC:RYPictureSelectCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func addPic (sender: RYPictureSelectCell?) {
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            print("访问相册失败")
            return
        }
        let picPicker = UIImagePickerController()
        picPicker.delegate = self
        //开启编辑
        picPicker.allowsEditing = true;
        selectCell = sender
        presentViewController(picPicker, animated: true, completion: nil)
    }
    func delectPci (sender : RYPictureSelectCell?) {
        let index = (sender?.tag)! - 100
        if images.count != 0 {
            images.removeAtIndex(index)
            selectCell = sender
            selectCell?.isPicAdded = false
            collectionView?.reloadData()
        }
    }
    
    //最好用下面的代替  iOS 2.0 以后
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //帮助文档中有各个键值的说明
//        let img = info["UIImagePickerControllerOriginalImage"] as! UIImage
        /*
        let UIImagePickerControllerMediaType: String
        let UIImagePickerControllerOriginalImage: String
        let UIImagePickerControllerEditedImage: String
        let UIImagePickerControllerCropRect: String
        let UIImagePickerControllerMediaURL: String
        let UIImagePickerControllerReferenceURL: String
        let UIImagePickerControllerMediaMetadata: String
        let UIImagePickerControllerLivePhoto: String
        */
        let img = info["UIImagePickerControllerEditedImage"] as! UIImage
        //如果cell中已经有图片了  就替换这个图片
        if selectCell!.isPicAdded == true  {
            images.removeAtIndex((selectCell?.tag)!-100)
            images.insert(img, atIndex: (selectCell?.tag)!-100)
        }else {
            images.append(img)
            selectCell?.isPicAdded = true
        }
        collectionView?.reloadData()
        //使用协议方法后   页面的 dismiss 就交给程序员了
        dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: - dataSource
extension RYPictureSelectVC {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + (images.count < maxPicNum ? 1 : 0)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RYPictureSelectCell
        cell.backgroundColor=col_darkGray
        cell.cellDelegate = self
        cell.tag = indexPath.row + 100
        if indexPath.row == images.count {
            cell.image = nil
            //保证复用的时候不会出问题
            cell.isPicAdded = false
        }else {
            cell.image = images[indexPath.row]
        }
        
        return cell
    }
}