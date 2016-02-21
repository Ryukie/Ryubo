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

    private lazy var statuses = [RYStatus]()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard userLogin == true else {
            visitorView?.setVisitorViewWithInfo(nil, titleText: "关注一些人，你将打开新世界的大门")
            return
        }
        prepareTableView()
        SVProgressHUD.show()
        RYStatusViewModel().loadHomeData { (tempArr) -> () in
            SVProgressHUD.dismiss()
            self.statuses = tempArr
            self.tableView.reloadData()
        }
    }
    
    //准备tableView
    private func prepareTableView() {
        tableView.separatorStyle = .None//隐藏分割线
        tableView.registerClass(RYHomeCell.self, forCellReuseIdentifier: HomeCellId)
        tableView.rowHeight = 44
        tableView.backgroundColor = col_lightGray
        autoRowHeight()
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
        return self.statuses.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //手写代码 必须手动注册cell
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeCellId, forIndexPath: indexPath) as! RYHomeCell
        cell.status = statuses[indexPath.row]
        return cell
    }
}
