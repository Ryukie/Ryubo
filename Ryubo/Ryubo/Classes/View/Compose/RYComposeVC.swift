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
    }
    @objc private func dismissVC () {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @objc private func sendWeibo () {
        print(__FUNCTION__)
    }
}
