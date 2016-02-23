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
    func delectPci () {
        print(__FUNCTION__)
    }
    //选择器的代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(info)
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - dataSource
extension RYPictureSelectVC {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RYPictureSelectCell
        cell.backgroundColor=col_darkGray
        cell.cellDelegate = self
        return cell
    }
}