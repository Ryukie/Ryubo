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
    
    var refreshState : RYRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal :
                lb_text.text = "下拉刷新"
            case .Pulling :
                lb_text.text = "松开刷新界面"
            case .Refreshing :
                lb_text.text = "正在刷新"
            }
        }
    }
    
    let h :CGFloat = 200
    override init(frame: CGRect) {
        let f = CGRectMake(0, -h, scrWidth, h)
        super.init(frame: f)
        backgroundColor = col_white95Gray
        setUI()
    }
    
    
    private func setUI () {
        addSubview(iv_look)
        iv_look.addSubview(indicatorView)
        iv_look.addSubview(lb_text)
        indicatorView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(lb_text.snp_top)
            make.left.equalTo(lb_text)
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
            print("是scrollView")
            scrollView = myFather
            //观察父视图的contentOffset 这个属性
            scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        }
    }
    
    //KVO监听方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //1.获取滚动的改变状态的临界值
        let conaditionValue = -((self.scrollView?.contentInset.top ?? 0) + h)
        //2.滚动视图的位移
        let offsetY = self.scrollView?.contentOffset.y ?? 0
        print(conaditionValue,offsetY)
        //3.比较 临界值 和 位移 来改变状态
        //怎么获取正在刷新的状态  超出临界值 并且 松手(dragging)
        print(scrollView!.dragging)
        print(refreshState)
        if scrollView!.dragging {
            //正在被拽动
            if  refreshState == .Normal && conaditionValue > offsetY {
                print("等待刷新状态")
                refreshState = .Pulling
            } else if refreshState == .Pulling && conaditionValue < offsetY {
                print("普通状态")
                refreshState = .Normal
            }
        } else {
            print("正在刷新")
            refreshState = .Refreshing
        }
    }
    //移除KVO监听者
}