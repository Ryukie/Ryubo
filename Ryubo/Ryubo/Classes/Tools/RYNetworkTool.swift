//
//  RYNetworkTool.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/5.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import AFNetworking

class RYNetworkTool: AFHTTPSessionManager {
//    func sharedNetToll () -> RYNetworkTool {
//        let baseURL = NSURL(string:"https://api.weibo.com/")
//        let instance = RYNetworkTool(baseURL: baseURL)
//        dispatch_once(<#T##predicate: UnsafeMutablePointer<dispatch_once_t>##UnsafeMutablePointer<dispatch_once_t>#>, <#T##block: dispatch_block_t##dispatch_block_t##() -> Void#>)
//        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
//        return instance
//    }
    static let sharedNetTool:RYNetworkTool = {
        let baseUrl = NSURL(string: "https://api.weibo.com/")
        let instance = RYNetworkTool(baseURL: baseUrl)
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        return instance
    }()
}
