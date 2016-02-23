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
    }
    
    @objc private func sendWeibo () {
        let URLString = "2/statuses/update.json"
        let parameters = ["access_token": RYAccountViewModel.sharedAccountViewModel.token,"status":tv_textInputView.text]
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
    private lazy var tv_textInputView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFontOfSize(18)
        tv.textColor = col_darkGray
        tv.backgroundColor = col_orange
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
}

// MARK: - 布局子控件
extension RYComposeVC {
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
        let itemSettings = [["imageName": "compose_toolbar_picture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"],
            ["imageName": "compose_add_background"]]
        for item in itemSettings {
            let imageName = item["imageName"]
            let bt = UIButton(backgroundImageName: nil, imageName: imageName)
            addTargetForItem(bt)
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
    private func addTargetForItem (item:UIButton) {
        itemIndex++
        switch itemIndex {
        case 1:
            item.addTarget(self, action: "clickPicAdd", forControlEvents: .TouchUpInside)
        case 2:
            item.addTarget(self, action: "clickAtAdd", forControlEvents: .TouchUpInside)
        case 3:
            item.addTarget(self, action: "clickSharpAdd", forControlEvents: .TouchUpInside)
        case 4:
            item.addTarget(self, action: "clickEmojAdd", forControlEvents: .TouchUpInside)
        case 5:
            item.addTarget(self, action: "clickMore", forControlEvents: .TouchUpInside)
        default:
            return
        }
    }
    
    //1 pic
    @objc private func clickPicAdd () {
//        print(__FUNCTION__)
        let vc = RYBasicNaviController(rootViewController: vc_picSelect)
        navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    //2 @
    @objc private func clickAtAdd () {
//        print(__FUNCTION__)
    }
    
    //3 #
    @objc private func clickSharpAdd () {
//        print(__FUNCTION__)
    }
    
    //4 emoj
    @objc private func clickEmojAdd () {
//        print(__FUNCTION__)
    }
    
    //5 more
    @objc private func clickMore () {
//        print(__FUNCTION__)
    }
    
    @objc private func whenKeyboardChange (n:NSNotification) {
//        print(n)
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