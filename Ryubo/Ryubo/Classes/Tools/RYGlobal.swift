//
//  RYGlobal.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/5.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

let app_key = "4034367702"
let app_scret = "dc124878d20ce54c9b962ca22b3154cd"
let redirect_URL = "http://www.baidu.com"
let codeInURL = "17f81165d8b74790ff1e2d6c58a35975"
// 2.00bOzbGCo1nB6Ebfb2b2efa91nmLaD  token
// https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00bOzbGCo1nB6Ebfb2b2efa91nmLaD

// MARK: - 各种通知
//切换到登陆后微博视图的通知
let didLoginChangeToWeiboView = "FireInTheHole"

//定义全局通用的错误提示
let netErrorText = "网络君正在睡觉中,请稍后再试..."

///自动布局margin
let margin : CGFloat = 10.0
///颜色
let col_darkGray = UIColor.darkGrayColor()
let col_lightGray = UIColor.lightGrayColor()
let col_white = UIColor.whiteColor()
let col_orange = UIColor.orangeColor()
let col_white95Gray = UIColor(white: 0.95, alpha: 1)
let col_retweetCol = UIColor(white: 0.9, alpha: 1)


/**
*  屏幕尺寸
*/
let scrWidth = UIScreen.mainScreen().bounds.size.width
let scrHeight = UIScreen.mainScreen().bounds.size.height

/**
*  图片配图间距
*/
let picCellMargin : CGFloat = 5

//emotionCellID
let emotionCellReuseID = "emotionCell"
