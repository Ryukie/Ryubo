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

//    private lazy var statuses = [RYStatus]()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard userLogin == true else {
            visitorView?.setVisitorViewWithInfo(nil, titleText: "关注一些人，你将打开新世界的大门")
            return
        }
        prepareTableView()
        SVProgressHUD.show()
        loadData()
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
//            NSThread.sleepForTimeInterval(2)
            if !self.tableView.dragging {
                //如果是一直拉着就不刷新
                self.tableView.reloadData()
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
        //将要加载最后一个cell的时候 并且小菊花没有转动的情况下
        if indexPath.row == RYStatusViewModel.sharedRYStatusViewModel.statuses.count - 1 && !indicatorView.isAnimating(){
            //1.转动小菊花
            indicatorView.startAnimating()
            //开始加载数据 加载更多数据
            loadData()
        }
        cell.status = RYStatusViewModel.sharedRYStatusViewModel.statuses[indexPath.row]
        return cell
    }
    let myRefresh = RYRefresh()
    //小菊花
    private lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
}
