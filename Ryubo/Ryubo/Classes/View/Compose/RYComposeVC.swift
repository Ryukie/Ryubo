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
        view.backgroundColor = col_orange
        setNaviItems()
    }
    
    private func setNaviItems () {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancle", style: .Plain, target: self, action: "dismissVC")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .Plain, target: self, action: "sendWeibo")
        navigationItem.rightBarButtonItem?.enabled = false
        setNaviTitle()
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
    
    @objc private func dismissVC () {
        dismissViewControllerAnimated(true, completion: nil)
        //TODO : 不为空的时候提示保存草稿
    }
    
    @objc private func sendWeibo () {
        print(__FUNCTION__)
    }
}
