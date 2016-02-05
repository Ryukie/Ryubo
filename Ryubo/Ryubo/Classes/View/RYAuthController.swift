//
//  RYAuthController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/5.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYAuthController: UIViewController {

    //用啦替换Views的webView
    let authView = UIWebView()
// MARK: - 用WEBView替换跟视图
    override func loadView() {
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(view)
        setupNaviBar()
    }
    private func setupNaviBar () {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "clickCloseBtn")
        // MARK: - 全局导航控制器的颜色最好提前设置 在AppDelegate中设置
    }
    @objc private func clickCloseBtn () {
//        print(__FUNCTION__)
        dismissViewControllerAnimated(true, completion: nil)
    }

}
