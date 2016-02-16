//
//  RYAuthController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/5.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking

class RYAuthController: UIViewController {

    //用啦替换Views的webView
    let authView = UIWebView()
// MARK: - 用WEBView替换跟视图
    override func loadView() {
        view = authView
        authView.delegate = self
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
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + app_key + "&redirect_uri=" + redirect_URL
        //可选的URL
        let URL = NSURL(string: urlString)!
        //获取request
        let request = NSURLRequest(URL: URL)
        authView.loadRequest(request)
    }
    private func setupNaviBar () {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "clickCloseBtn")
        // MARK: - 全局导航控制器的颜色最好提前设置 在AppDelegate中设置
        
        //设置默认测试账号
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TestAC", style: .Plain, target: self, action: "defaultTestAccount")
    }
    @objc private func defaultTestAccount() {
        let jsString = "document.getElementById('userId').value = '13407157710', document.getElementById('passwd').value = 'wrq39zhong' "
        authView.stringByEvaluatingJavaScriptFromString(jsString)
    }
    @objc private func clickCloseBtn () {
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
        
        //返回true 让web加载
        //返回false 拦截
        
        //无法获取URL字符串就不加载
        guard let URLString = request.URL?.absoluteString else {
            return false
        }
// MARK: - 获取授权code
        //从请求中获取code授权码
        if URLString.containsString("code=") {
            //获取URL中的参数  ->>> 即 URL  ? 后面的部分
            guard let query = request.URL?.query else {
                return false
            }
            let coder = "code="
            //将query转化为字符串
            //方法一: 转化为OC NSString 的方法
//            let code = (query as NSString).substringFromIndex(coder.characters.count)
            //方法二: Swift 的字符串处理方法
            let code = query.substringFromIndex(coder.endIndex)
//            print(code,query)
            
// MARK: - 获取授权token
//            getAccessToken(code)
            RYAccountViewModel().getAccessToken(code, finished: { (isLogin) -> () in
                if isLogin == false {
                    print("用户登录失败")
                    //HUD 提示用户 登录失败
                    SVProgressHUD.showErrorWithStatus("网络君正在睡觉,请稍后再试")
                    return
                }
                //走到这里一定登录成功
                SVProgressHUD.showSuccessWithStatus("登录成功")
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    //发送跳转通知
                    //由于通知方法是同步执行的，在切换控制器前，一定要确保当前控制器已经被完全卸载
                    NSNotificationCenter.defaultCenter().postNotificationName(didLoginChangeToWeiboView, object: nil)
                })
            })
            return false
        }
        return true
    }

}