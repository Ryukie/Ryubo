//
//  RYRefresh.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/22.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit


//自定义枚举 各个阶段的状态
enum RYRefreshState: Int {
    case Normal = 1     //普通状态
    case Pulling = 2    //下拉到等待刷新状态
    case Refreshing = 3 //正在刷新状态
}

//自定义下拉刷新控件 只正对 UIScrollView 及其子类对象
class RYRefresh: UIControl {
    var oldState : RYRefreshState = .Normal
    var refreshState : RYRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal :
                lb_text.text = "下拉刷新"
                indicatorView.hidden = true
                lb_text.hidden = false
            case .Pulling :
                lb_text.text = "松开刷新界面"
                lb_text.hidden = false
                indicatorView.hidden = true
            case .Refreshing :
                
                
                
                //想要调用加载数据的方法需要手动完成一次 valueChange
                sendActionsForControlEvents(.ValueChanged)
                lb_text.text = "正在刷新"
                indicatorView.hidden = false
                lb_text.hidden = true
            }
            oldState = refreshState
        }
    }
    
    let h :CGFloat = 200
    override init(frame: CGRect) {
        let f = CGRectMake(0, -h, scrWidth, h)
        super.init(frame: f)
        backgroundColor = UIColor(red: 245/255.0, green: 246/255.0, blue: 247/255.0, alpha: 1)
        setUI()
    }
    
    
    private func setUI () {
        addSubview(iv_look)
        iv_look.addSubview(indicatorView)
        iv_look.addSubview(lb_text)
        indicatorView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
//            make.left.equalTo(lb_text)
            make.size.equalTo(CGSize(width: 200, height: 35))
        }
        iv_look.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom)
            make.centerX.equalTo(self.snp_centerX)
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        lb_text.snp_makeConstraints { (make) -> Void in
            make.bottom.left.equalTo(iv_look)
            make.width.equalTo(200)
        }
        setAnimation()
        //TODO : 通过监视下拉距离来显示菊花并刷新
        indicatorView.startAnimating()
    }
    private func setAnimation () {
        let imagA = UIImage(named: "empty_list_search_1")
        let imagB = UIImage(named: "empty_list_search_2")
        let imgs:[UIImage] = [imagA!,imagB!]
        iv_look.animationImages = imgs
        iv_look.animationDuration = 0.5
        iv_look.animationRepeatCount = 0
        iv_look.startAnimating()
        iv_look.sizeToFit()
    }
    
    private var scrollView: UIScrollView?//用来存放父控件
    private lazy var iv_look : UIImageView = UIImageView()
    private lazy var lb_text : UILabel = UILabel(text: "下拉刷新", fontSize: 14, textColor: col_darkGray)
    private lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func endAnimation () {
        //设置延时   提高用户体验
        NSThread.sleepForTimeInterval(1.0)
        refreshState = .Normal
    }
    //移除KVO监听者
    deinit {
        scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
}
// MARK: - KVO  观察tableView的位移
extension RYRefresh {
    
    //将要添加到俯父视图
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        if let myFather = newSuperview as? UIScrollView {
            //将父视图记录下来
            scrollView = myFather
            //观察父视图的偏移量
            scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        }
    }
    
    //KVO监听方法   偏移量变动的时候调用该方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //拉到一定程度改变刷新状态
        let conaditionValue = -((self.scrollView?.contentInset.top ?? 0) + h)
        //当前偏移量
        let offsetY = self.scrollView?.contentOffset.y ?? 0
        //根据是否正在拉  和   是否达到刷新偏移量   来设置状态
        if scrollView!.dragging {
            //正在被拽动
            if  refreshState == .Normal && conaditionValue > offsetY {
                refreshState = .Pulling
            } else if refreshState == .Pulling && conaditionValue < offsetY {
                refreshState = .Normal
            }
        } else {
            //松手 && 满足 准备刷新的状态
            if refreshState == .Pulling {
                refreshState = .Refreshing
            }
        }
    }
    //移除KVO监听者
}