//
//  RYNetworkTool.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/5.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestStyle : String {
    case POST = "POST"
    case GET = "GET"
}

class RYNetworkTool: AFHTTPSessionManager {
    static let sharedNetTool:RYNetworkTool = {
        let baseUrl = NSURL(string: "https://api.weibo.com/")
        let instance = RYNetworkTool(baseURL: baseUrl)
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        instance.responseSerializer.acceptableContentTypes?.insert("text/html")
        return instance
    }()
    func requestSend (requestStye : RequestStyle ,URLString : String,parameter : [String:AnyObject]? ,finished:(success:[String:AnyObject]? ,error:NSError?)->()) {
        if requestStye == .POST {
            POST(URLString, parameters: parameter, progress: nil, success: { (_, result) -> Void in
                //将 Anyobject对象转换为 字典格式数据
                guard let dict = result as? [String : AnyObject] else {
                    print("数据格式不合法")
                    let myError = NSError(domain: "呵呵数据格式不合法", code: 998, userInfo: nil)
                    //执行失败的回调
                    finished(success: nil, error: myError)
                    return
                }
                //执行成功的回调
                finished(success: dict, error: nil)
                }, failure: { (_ , error ) -> Void in
                    finished(success: nil, error: error)
            })
        }else {
            GET(URLString, parameters: parameter, progress: nil, success: { (_, result) -> Void in
                guard let dict = result as? [String:AnyObject] else {
                    print("数据格式不和法")
                    let myError = NSError(domain: "呵呵数据格式不合法", code: 998, userInfo: nil)
                    //执行失败的回调
                    finished(success: nil, error: myError)
                    return
                }
                finished(success: dict, error: nil)
                }, failure: { (_ , error ) -> Void in
                    finished(success: nil, error: error)
            })
        }
    }
}
