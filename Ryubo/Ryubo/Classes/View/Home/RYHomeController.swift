//
//  RYHomeController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/1/30.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

private let HomeCellId = "HomeCell"

class RYHomeController: RYBasicVisitorTVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard userLogin == true else {
            visitorView?.setVisitorViewWithInfo(nil, titleText: "关注一些人，你将打开新世界的大门")
            return
        }
        prepareTableView()
        SVProgressHUD.show()
        loadData()
//        setBadgeIcon()
        
        //定时刷新badge
        let timer = NSTimer(timeInterval: 30, target: self, selector: "setBadgeIcon", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        loadData()
    }
    //准备tableView
    private func prepareTableView() {
        tableView.separatorStyle = .None//隐藏分割线
        tableView.registerClass(RYHomeCell.self, forCellReuseIdentifier: HomeCellId)
        tableView.rowHeight = 44
        tableView.backgroundColor = col_lightGray
        autoRowHeight()
        //下拉刷新   改成自定义控件
        tableView.addSubview(myRefresh)
        myRefresh.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        //添加底部小菊花   上拉刷新
        tableView.tableFooterView = indicatorView
    }
    @objc private func loadData() {
        //通过判断上啦小菊花是否转动排判断 上下啦动
        RYStatusViewModel.sharedRYStatusViewModel.loadHomeData(indicatorView.isAnimating()) { (isSuccess) -> () in
            SVProgressHUD.dismiss()
            //停止刷新数据
            self.myRefresh.endAnimation()
            if !isSuccess {
                //请求首页数据失败
                SVProgressHUD.showErrorWithStatus(netErrorText)
                return
            }
            
            //停止 上拉加载更多数据的小菊花转动动画
            if self.indicatorView.isAnimating() {
                //停止转动
                self.indicatorView.stopAnimating()
            }
            //请求数据一定成功
            //刷新列表
            if !self.tableView.dragging {
                //如果是一直拉着就不刷新
                self.tableView.reloadData()
                self.setBadgeIcon()
            }
        }
    }
    private func autoRowHeight () {
        //1.设置行高为自动计算行高
        //2.设置预估行高
        //3.给tableView的cell的容器视图设置一个 自上而下的约束
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //设置预估行高
        self.tableView.estimatedRowHeight = 300
    }
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RYStatusViewModel.sharedRYStatusViewModel.statuses.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //手写代码 必须手动注册cell
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeCellId, forIndexPath: indexPath) as! RYHomeCell
        cell.status = RYStatusViewModel.sharedRYStatusViewModel.statuses[indexPath.row]
        //将要加载最后一个cell的时候 并且小菊花没有转动的情况下
        if indexPath.row == RYStatusViewModel.sharedRYStatusViewModel.statuses.count - 1 && !indicatorView.isAnimating(){
            //1.转动小菊花
            indicatorView.startAnimating()
            //开始加载数据 加载更多数据
            loadData()
        }
        return cell
    }
    //小菊花
    private lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    //获取并显示badgeIcon
    @objc private func setBadgeIcon () {
        print(__FUNCTION__)
        /*
        必选	类型及范围	说明
        source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
        access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
        uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
        callback	false	string	JSONP回调函数，用于前端调用返回JS格式的信息。
        unread_message	false	boolean	未读数版本。0：原版未读数，1：新版未读数。默认为0。

        */
        let account = RYAccountViewModel.sharedAccountViewModel.userAccount
        let uid = (account?.uid)! as NSString
        var parameter = [String : AnyObject]()
        parameter["access_token"] = account?.access_token
        parameter["uid"] = uid.integerValue
//        parameter["unread_message"] = 1
//        print(parameter)
        RYNetworkTool.sharedNetTool.requestSend(.GET, URLString: "2/remind/unread_count.json", parameter: parameter) { (success, error) -> () in
            if success != nil {
//                print(success)
                let dict = success! as [String:AnyObject]
//                print(dict)
                let unread = RYUnread(dict: dict)
                print(unread.status)
                if unread.status == 0 {
                    self.tabBarItem.badgeValue = nil
                    return
                }
                self.tabBarItem.badgeValue = "\(unread.status)"
            }else {
                print(error)
            }
        }
    }
}
