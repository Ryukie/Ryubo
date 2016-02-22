//
//  RYComposeVC.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/22.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYComposeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = col_white
        setNaviItems()
    }
    
    private func setNaviItems () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancle", style: .Plain, target: self, action: "dismissVC")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "sendWeibo")
        navigationItem.rightBarButtonItem?.enabled = false
        setNaviTitle()
        setTextView()
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
    }
    @objc func hideTextLabel () {
        lb_backText.hidden = true
    }
    
    @objc private func dismissVC () {
        dismissViewControllerAnimated(true, completion: nil)
        //TODO : 不为空的时候提示保存草稿
    }
    
    @objc private func sendWeibo () {
        print(__FUNCTION__)
    }
    
    //1.textView
    private lazy var tv_textInputView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFontOfSize(18)
        tv.textColor = col_darkGray
        tv.backgroundColor = col_orange
        return tv
    }()
    private lazy var lb_backText:UILabel = UILabel(text: "Please Say Some Intresting Thing", fontSize: 18, textColor: col_darkGray)
}
