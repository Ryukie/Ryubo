//
//  RYAuthController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/5.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        //加载授权界面
        loadAuthPage()
    }
    private func loadAuthPage () {
        //1. 获取url
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + "4034367702" + "&redirect_uri=" + "http://www.baidu.com"
        //可选的URL
        let URL = NSURL(string: urlString)!
        //获取request
        let request = NSURLRequest(URL: URL)
        authView.loadRequest(request)
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


//swift中 这样写  是将一类的协议方法  写在一起 更加好阅读 和 维护
//同一类的协议方法  就被放在一个扩展中
extension RYAuthController:UIWebViewDelegate {
    //显示 用户等待指示器
    func webViewDidStartLoad(webView: UIWebView) {
        //显示
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //隐藏
        SVProgressHUD.dismiss()
    }
    
    //非常重要的协议方法
    //通常协议方法 返回值 为 bool类型  返回 yes 通常控件可以正常运行
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        print(request.URL)
        
        return true
    }
    
}