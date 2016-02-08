//
//  RYWelcomeController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/8.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SnapKit

class RYWelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        view = iv_backImageView
    }
    override func viewWillLayoutSubviews() {
        self.view.addSubview(iv_headIcon)
        self.view.addSubview(lb_welcomeWords)
        //设置头像位置
        iv_headIcon.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iv_backImageView.snp_centerX)
            make.centerY.equalTo(iv_backImageView.snp_centerY).offset(-100)
        }
        lb_welcomeWords.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iv_headIcon.snp_bottom).offset(10)
            make.centerX.equalTo(iv_headIcon.snp_centerX)
        }
        iv_headIcon.layer.cornerRadius = 42.5
        iv_headIcon.layer.masksToBounds = true
//        print(iv_headIcon.frame)
    }
    
// MARK: - 懒加载控件
    //背景图片
    private lazy var iv_backImageView : UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    //用户头像
    private lazy var iv_headIcon : UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    //欢迎语
    private lazy var lb_welcomeWords : UILabel = {
        let lb = UILabel()
        lb.text = RYAccountViewModel().userName! + " 欢迎回来"
        lb.textColor = UIColor.blackColor()
        lb.textAlignment = .Center
        lb.font = UIFont.systemFontOfSize(16)
        lb.sizeToFit()
        return lb
    }()
    
}
