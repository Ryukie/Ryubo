//
//  RYBottomView.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/18.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYBottomView: UIView {
    //找到自定义的入口
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setClickEvents()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: 懒加载子视图
    //转发微博的按钮
    private lazy var bt_retweeted: UIButton = UIButton(backgroundImageName: nil , titleText: "转发", textFont: 10, textColor: col_darkGray, imageName: "timeline_icon_retweet")
    // 评论
    private lazy var bt_comment: UIButton = UIButton(backgroundImageName: nil, titleText: "评论", textFont: 10, textColor: col_darkGray, imageName: "timeline_icon_comment")
    //点赞
    private lazy var bt_like: UIButton = UIButton(backgroundImageName: nil , titleText: "赞", textFont: 10, textColor: col_darkGray, imageName: "timeline_icon_unlike")
// MARK: - 配置点击事件
    private func setClickEvents () {
        bt_comment.addTarget(self, action: "clickBtComment", forControlEvents: .TouchUpInside)
        bt_like.addTarget(self, action: "clickBtLike", forControlEvents: .TouchUpInside)
        bt_retweeted.addTarget(self, action: "clickBtRetweet", forControlEvents: .TouchUpInside)
    }
    @objc private func clickBtComment () {
        //需要获取到当前的导航控制器来执行点击按钮跳转
        //可以通过闭包/通知/代理等方法实现
        //这里通过遍历响应者链条来获取navi
        //这种方式用的很多可以代替很多情况下的协议代理
        getNaviFromResponderChain()?.pushViewController(RYCommentVC(), animated: true)
    }
    @objc private func clickBtRetweet () {
        getNaviFromResponderChain()?.pushViewController(RYRetweetVC(), animated: true)
    }
    @objc private func clickBtLike () {
        print("I`m lovin it!")
    }
}
//========================================================
// MARK: - 自动布局子控件
extension RYBottomView {
    //MARK: 设置视图
    private func setupUI() {
        backgroundColor = col_white
        addSubview(bt_retweeted)
        addSubview(bt_like)
        addSubview(bt_comment)
        bt_retweeted.snp_makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self)
        }
        bt_comment.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bt_retweeted.snp_right)
            make.bottom.top.equalTo(self)
            make.width.equalTo(bt_retweeted.snp_width)
        }
        bt_like.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bt_comment.snp_right)
            make.bottom.top.equalTo(self)
            make.right.equalTo(self.snp_right)
            make.width.equalTo(bt_comment.snp_width)
        }
        addSeparateLineView()
    }
// MARK: - 设置两条分割线
    private func addSeparateLineView () {
        let lineA = getSeparateLineView()
        let lineB = getSeparateLineView()
        addSubview(lineA)
        addSubview(lineB)
        let w: CGFloat = 0.5
        let scale: CGFloat = 0.4
        lineA.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bt_retweeted.snp_right)
            make.centerY.equalTo(self.snp_centerY)
            make.height.equalTo(self.snp_height).multipliedBy(scale)
            make.width.equalTo(w)
        }
        lineB.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bt_comment.snp_right)
            make.centerY.equalTo(self.snp_centerY)
            make.height.equalTo(self.snp_height).multipliedBy(scale)
            make.width.equalTo(w)
        }
    }
    private func getSeparateLineView () -> UIView {
        let line = UIView()
        line.backgroundColor = col_lightGray
        return line
    }
}
