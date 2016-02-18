//
//  RYHomeController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/1/30.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import AFNetworking


private let HomeCellId = "HomeCell"

class RYHomeController: RYBasicVisitorTVC {

    private lazy var statuses = [RYStatus]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(userLogin)
        guard userLogin == true else {
            visitorView?.setVisitorViewWithInfo(nil, titleText: "关注一些人，你将打开新世界的大门")
            return
        }
        prepareTableView()
        RYStatusViewModel().loadHomeData { (tempArr) -> () in
            self.statuses = tempArr
            self.tableView.reloadData()
        }
    }
    
    //准备tableView
    private func prepareTableView() {
        self.tableView.registerClass(RYHomeCell.self, forCellReuseIdentifier: HomeCellId)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeCellId, forIndexPath: indexPath)
        //显示文案
        cell.textLabel?.text = self.statuses[indexPath.row].user?.name
//        print(cell)
        return cell
    }


}
