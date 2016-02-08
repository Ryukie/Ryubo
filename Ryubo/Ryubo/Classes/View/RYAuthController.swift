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
            getAccessToken(code)
            return false
        }
        return true
    }
    
    private func getAccessToken(code:String) {
        let URLString = "https://api.weibo.com/oauth2/access_token"
        let parameters = [
            "client_id":app_key,
            "client_secret": app_scret,
            "grant_type":"authorization_code",
            "code": code,
            "redirect_uri": redirect_URL
        ]
        let manager = RYNetworkTool.sharedNetTool
        //用这个方法才对
        manager.POST(URLString, parameters: parameters, progress: nil, success: { (_ , result) -> Void in
            //将 Anyobject对象转换为 字典格式数据
            guard let dict = result as? [String : AnyObject] else {
                print("数据格式不合法")
                return
            }
            //对象转字典成功后
            let account = RYUserAccount(dict: dict)
            //设置用户数据
            self.loadUserInfo(account)
            }) { (_ , error) -> Void in
                print(error)
        }
    }
    private func loadUserInfo(account:RYUserAccount){
        //用户数据接口
        let urlString = "https://api.weibo.com/2/users/show.json"
        //需要传递的参数
        //OC  {"nullobject" : [NSNull null]}
// MARK: - 程序员保证这个地方一定有值,否则参数哪里会报错
        let parameters = ["access_token": account.access_token!, "uid": account.uid!]
        let manager = RYNetworkTool.sharedNetTool
        manager.GET(urlString, parameters: parameters, progress: nil, success: { (_, result) -> Void in
//            print(result)
// MARK: - 将用户数据转化为字典
            guard let dict = result as? [String:AnyObject] else {
                print("数据格式不和法")
                return
            }
            
            let name = dict["name"] as! String //OC NSString 转String
            let avatar_large = dict["avatar_large"] as! String
            //我们需要的用户信息就全部获取到
            account.name = name
            account.avatar_large = avatar_large
            print(account)
            account.saveAccount()
            }) { (_ , error) -> Void in
                print(error)
        }
    }
}