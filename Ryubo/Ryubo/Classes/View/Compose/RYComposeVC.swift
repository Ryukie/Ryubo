//
//  RYComposeVC.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/22.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SVProgressHUD

class RYComposeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = col_white
        setNaviItems()
        setNaviTitle()
        setTextView()
        setBottomToolBar()
        setPicSelectVC()
    }
    
    @objc private func sendWeibo () {
        
        //判断用户是否登录
        guard RYAccountViewModel.sharedAccountViewModel.userLogin else {
            SVProgressHUD.showErrorWithStatus("PleaseLogin", maskType: .Gradient)
            return
        }
        
        var URLString = "2/statuses/update.json"
        let parameters = ["access_token": RYAccountViewModel.sharedAccountViewModel.token,"status":tv_textInputView.text]
        
        if vc_picSelect.images.count != 0{
            //获取图片二进制数据
            // Returns the data for the specified image in PNG format
            //图片上传接口
            URLString = "https://upload.api.weibo.com/2/statuses/upload.json"

            //上传
            //data: 要上传的文件的二进制数据
            //name: 服务器接受的字段
            //fileName: 服务器存储的文件名  但是在这个地方 可以 '乱写' 生成 高清/中等/缩略图
            //mineType: 告诉服务器上传的文件类型
            //图片: image/jpeg  不关注文件类型可以使用:application/octet-stream(八进制的流)
            RYNetworkTool.sharedNetTool.POST(URLString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
                //将图片二进制文件传入拼接入 fromData
                //多张图片上传   需要高级接口
//                for i in 0..<(self.vc_picSelect.images.count) {
                    let img = self.vc_picSelect.images[0]
                    let strName = "pic"
                    let strFile = "Ryukie" + "\(1)"
                    print(strFile)
                    let imagData = UIImagePNGRepresentation(img)
                    formData.appendPartWithFileData(imagData!, name: strName, fileName: strFile, mimeType: "image/jpeg")
//                }
                }, progress: nil , success: { (_ , result) -> Void in
                    //                    print(result)
                    SVProgressHUD.showInfoWithStatus("发布成功", maskType: .Gradient)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }, failure: { (_ , error ) -> Void in
                    print(error)
                    SVProgressHUD.showErrorWithStatus(netErrorText)
            })
            
        }else {
            RYNetworkTool.sharedNetTool.requestSend(.POST, URLString: URLString, parameter: parameters) { (success, error) -> () in
                if error != nil {
                    //出错啦
                    SVProgressHUD.showErrorWithStatus(netErrorText)
                    return
                }
                //发布成功
                SVProgressHUD.showSuccessWithStatus("发布成功")
                self.dismissVC()
            }
        }
    }
// MARK: - 点击关闭按钮的话   键盘会晚于控制器消失    为了提高体验   在控制器将要消失的时候推掉键盘
    override func viewWillDisappear(animated: Bool) {
        tv_textInputView.resignFirstResponder()
    }
    
    @objc func hideTextLabel () {
        lb_backText.hidden = true
    }
    
    @objc private func dismissVC () {
        dismissViewControllerAnimated(true, completion: nil)
        //TODO : 不为空的时候提示保存草稿
    }
    //1.textView
    private lazy var tv_textInputView: EmoticonTextView = {
        let tv = EmoticonTextView()
        tv.font = UIFont.systemFontOfSize(18)
        tv.textColor = col_darkGray
        tv.backgroundColor = col_white95Gray
        //开启垂直方向的 弹簧效果
        tv.alwaysBounceVertical = true
        //设置键盘隐藏的方式 iOS7.0
        tv.keyboardDismissMode = .OnDrag
        return tv
    }()
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    private lazy var lb_backText:UILabel = UILabel(text: "Please Say Some Intresting Thing", fontSize: 18, textColor: col_darkGray)
    private lazy var tb_bottomToolBar : UIToolbar = UIToolbar()
    var itemIndex : Int64 = 0
    private lazy var vc_picSelect : RYPictureSelectVC = RYPictureSelectVC()
    //插入表情键盘
    private lazy var v_emotionKryboard: EmoticonKeyBoardView = EmoticonKeyBoardView { (em) -> () in
//        print(em)
        //在闭包中智能提示 不怎么样  系统键盘存在的时候 输入视图 为 nil
        self.tv_textInputView.insetText(em)
    }
}

// MARK: - 布局子控件
extension RYComposeVC {
    private func setPicSelectVC () {
        addChildViewController(vc_picSelect)
        view.addSubview(vc_picSelect.view)
        //将工具条移到顶部
        view.bringSubviewToFront(tb_bottomToolBar)
        vc_picSelect.view.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(0)
        }
    }
    
    private func setNaviItems () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancle", style: .Plain, target: self, action: "dismissVC")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "sendWeibo")
        navigationItem.rightBarButtonItem?.enabled = false
    }
    
    // MARK: - 自定义titleView 默认是 nil  不能够直接进行addSubView
    private func setNaviTitle () {
        //自定义标题视图
        let myTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        let lb_title = UILabel(text: "PostWeibo", fontSize: 17, textColor: col_darkGray)
        let lb_userName = UILabel(text: RYAccountViewModel.sharedAccountViewModel.userName!, fontSize: 14, textColor: col_lightGray)
        myTitleView.addSubview(lb_title)
        myTitleView.addSubview(lb_userName)
        //设置布局
        lb_title.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(myTitleView.snp_centerX)
            make.top.equalTo(myTitleView.snp_top)
        }
        
        lb_userName.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(myTitleView.snp_centerX)
            make.bottom.equalTo(myTitleView.snp_bottom)
        }
        navigationItem.titleView = myTitleView
    }
    //MARK: 设置 textView
    private func setTextView() {
        view.addSubview(tv_textInputView)
        tv_textInputView.delegate = self
        //设置约束
        tv_textInputView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top)
            make.left.right.equalTo(self.view)
            //设置高度
            make.height.equalTo(scrHeight / 3)
        }
        
        //添加占位文本
        tv_textInputView.addSubview(lb_backText)
        //设置占位文本的约束
        lb_backText.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tv_textInputView.snp_top).offset(8)
            make.left.equalTo(tv_textInputView.snp_left).offset(5)
        }
        //开始输入隐藏文本
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideTextLabel", name: UITextViewTextDidBeginEditingNotification, object: tv_textInputView)
        //弹出或收回键盘移动工具栏
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "whenKeyboardChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    private func setBottomToolBar () {
        //toolBar默认高度44
        view.addSubview(tb_bottomToolBar)
        tb_bottomToolBar.backgroundColor = col_orange
        tb_bottomToolBar.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(view)
        }
        //子工具控件集合
        var items = [UIBarButtonItem]()
        let itemSettings = [
            //通过键值对设置背景图片   和   绑定方法
            ["imageName": "compose_toolbar_picture",
            "actionName": "clickPicAdd"],
            
            ["imageName": "compose_mentionbutton_background",
                "actionName": "clickAtAdd"],
            
            ["imageName": "compose_trendbutton_background",
                "actionName": "clickSharpAdd"],
            
            ["imageName": "compose_emoticonbutton_background",
                "actionName": "clickEmojAdd"],
            
            ["imageName": "compose_add_background",
                "actionName": "clickMore"]
        ]
        
        for item in itemSettings {
            let imageName = item["imageName"]
            let bt = UIButton(backgroundImageName: nil, imageName: imageName)
            
            if let actionName = item["actionName"] {
                bt.addTarget(self, action: Selector(actionName), forControlEvents: .TouchUpInside)
            }
            let barItem = UIBarButtonItem(customView: bt)
            items.append(barItem)
            //添加弹簧用来自动设置item间距
            let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        //删除最后一个弹簧
        items.removeLast()
        tb_bottomToolBar.items = items
    }
    
    //1 pic
    @objc private func clickPicAdd () {
        
//        let vc = RYBasicNaviController(rootViewController: vc_picSelect)
//        navigationController?.presentViewController(vc, animated: true, completion: nil)
        //更新高度
        if vc_picSelect.isShowed == false {
            tv_textInputView.resignFirstResponder()
            vc_picSelect.isShowed = true
            vc_picSelect.view.snp_updateConstraints { (make) -> Void in
                make.height.equalTo(scrHeight*2/3)
            }
        }else {
            vc_picSelect.isShowed = false
            vc_picSelect.view.snp_updateConstraints { (make) -> Void in
                make.height.equalTo(0)
            }
        }
        //强制刷新界面
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    //2 @
    @objc private func clickAtAdd () {
        print(__FUNCTION__)
    }
    
    //3 #
    @objc private func clickSharpAdd () {
        print(__FUNCTION__)
    }
    
    //4 emoj
    @objc private func clickEmojAdd () {
//        print(__FUNCTION__)
        //先取消第一响应者
        tv_textInputView.resignFirstResponder()
        tv_textInputView.inputView = tv_textInputView.inputView == nil ? v_emotionKryboard : nil
        //成为第一响应者调出键盘
        tv_textInputView.becomeFirstResponder()
    }
    
    //5 more
    @objc private func clickMore () {
        print(__FUNCTION__)
    }
    
    @objc private func whenKeyboardChange (n:NSNotification) {
//        print(n)
        if vc_picSelect.isShowed == true {
            clickPicAdd()
        }
        //获取动画时间
        let duration = (n.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //NSRect  是一个结构体  结构体需要包装成 NSValue
        let endRect = (n.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let offsetY = -scrHeight + endRect.origin.y
        UIView.animateWithDuration(duration) { () -> Void in
            //修改底部约束
            self.tb_bottomToolBar.snp_updateConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self.view.snp_bottom).offset(offsetY)
            })
            
            //设置动画曲线
            let curve = (n.userInfo![UIKeyboardAnimationCurveUserInfoKey] as!NSNumber).integerValue
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
            /*
            苹果官方没有提供关于 UIViewAnimationCurve 数值等于 7 的文档说明，不过通过实际测试发现，可以设置动画的优先级
            UIViewAnimationCurve == 7 时
            如果图层之前动画没有结束，会被终止并执行后续的动画
            同时将动画时长修改为 0.5 s，并且设定的动画时长不再有效
            */
            
            //强制刷新
            self.view.layoutIfNeeded()
        }
    }

}
extension RYComposeVC: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        //隐藏占位文本
        lb_backText.hidden = textView.hasText()
        //开始 右导航按钮的交互
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
}