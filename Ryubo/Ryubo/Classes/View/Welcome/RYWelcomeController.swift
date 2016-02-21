//
//  RYWelcomeController.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/8.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class RYWelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func loadView() {
        view = iv_backImageView
    }
    override func viewWillLayoutSubviews() { //默认情况什么都不做
//        setUpUI()
        //千万别放这...开始放这了动画更新frame的时候控制台报错
    }
    override func viewDidLayoutSubviews() {
//        setUpUI()
        //放在这里也报错
    }
    private func setUpUI () {
        self.view.addSubview(iv_headIcon)
        self.view.addSubview(lb_welcomeWords)
        //设置头像位置
        iv_headIcon.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view.snp_centerX)
            make.centerY.equalTo(self.view.snp_centerY)
            make.size.equalTo(CGSizeMake(85, 85))
        }
        lb_welcomeWords.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iv_headIcon.snp_bottom).offset(10)
            make.centerX.equalTo(iv_headIcon.snp_centerX)
        }
        iv_headIcon.layer.cornerRadius = 42.5
        iv_headIcon.layer.masksToBounds = true
        
        lb_welcomeWords.alpha = 0
        //        print(iv_headIcon.frame)
        
        //显示用户头像
        iv_headIcon.sd_setImageWithURL(RYAccountViewModel.sharedAccountViewModel.userHeadIconURL, placeholderImage: UIImage(named: "avatar_default_big"))
    }
    //动画效果不推荐在viewDidLoad/loadView中执行动画
    //推荐在ViewDidAppear中执行动画效果
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        showAnimetion()
    }
    private func showAnimetion () {
        //在动画闭包中修改 头像的地步约束
        //更新某一条已经添加过的约束  如果该约束不存在 会自动添加该约束
        
        //1.usingSpringWithDamping: 弹簧系数  0.1 ~ 1  越小 越弹
        //2.initialSpringVelocity 加速度
        //options:动画可选项  OC按位枚举 swift: 数组
        
        //弹簧系数设置准则 (弹簧系数 * 10 ~= 加速度)
        
        //使用自动布局 + 动画闭包 ====> 强制刷新视图
        let offset = -100
        
        
        //更新写在闭包外面动画依旧可以执行  这里只是收集了约束的变化并没有更新布局
        self.iv_headIcon.snp_updateConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(self.view.snp_centerY).offset(offset)
        })
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.98, initialSpringVelocity: 9.8, options: [], animations: { () -> Void in
                        
            //强制刷新视图
            self.view.layoutIfNeeded()
            }) { (_ ) -> Void in
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.lb_welcomeWords.alpha = 1
                    }, completion: { (_ ) -> Void in
                        NSThread.sleepForTimeInterval(1.0)
                        self.showMainWeiboView()
                })
                
                //下面这种会闪
                
//            UIView.animateWithDuration(0.25, animations: { () -> Void in
//                self.lb_welcomeWords.alpha = 1
//                self.showMainWeiboView()
//            })
        }
    }
    
// MARK: - 动画完毕的时候发出通知,切换根控制器
    private func showMainWeiboView () {
        //发出通知
        NSNotificationCenter.defaultCenter().postNotificationName(didLoginChangeToWeiboView, object: "FromOAuth")
    }
    
// MARK: - 懒加载控件
    //背景图片
    private lazy var iv_backImageView : UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    //用户头像
    private lazy var iv_headIcon : UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    //欢迎语
//    private lazy var lb_welcomeWords : UILabel = UILabel(text: RYAccountViewModel.sharedAccountViewModel.userName! + " 欢迎回来", fontSize: 16, textColor: UIColor.grayColor())
    private lazy var lb_welcomeWords : UILabel = UILabel(text:" 欢迎回来", fontSize: 16, textColor: UIColor.grayColor())
    
}
