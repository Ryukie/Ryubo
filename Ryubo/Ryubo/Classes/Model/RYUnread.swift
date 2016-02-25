//
//  RYUnread.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/25.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYUnread: NSObject {
    /*
    
    返回值字段	字段类型	字段说明
    status	int	新微博未读数
    follower	int	新粉丝数
    cmt	int	新评论数
    dm	int	新私信数
    mention_status	int	新提及我的微博数
    mention_cmt	int	新提及我的评论数
    group	int	微群消息未读数
    private_group	int	私有微群消息未读数
    notice	int	新通知未读数
    invite	int	新邀请未读数
    badge	int	新勋章数
    photo	int	相册消息未读数
    msgbox	int	{{{3}}}
    
    */
    /// 新微博未读数
    var status : Int = 0
    /// 新粉丝数
    var follower : Int = 0
    /// 新评论数
    var cmt : Int = 0
    /// 新私信数
    var dm : Int = 0
    /// 新提及我的微博数
    var mention_status : Int = 0
    /// 新提及我的评论数
    var mention_cmt	: Int = 0
    /// 微群消息未读数
    var group : Int = 0
    /// 私有微群消息未读数
    var private_group : Int = 0
    /// 新通知未读数
    var notice : Int = 0
    /// 新邀请未读数
    var invite : Int = 0
    /// 新勋章数
    var badge : Int = 0
    /// 相册消息未读数
    var photo : Int = 0
 /// {{{3}}}
    var msgbox : Int = 0
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //undefineKey 
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    override var description : String {
        //使用kvc方式 获取对象 的字典信息
        let keys = ["status","follower","cmt","dm","mention_status","mention_cmt","group","private_group","notice","invite","badge","photo","msgbox"]
        let dict = self.dictionaryWithValuesForKeys(keys)
        return dict.description
    }
    //获取未读参数
    func getUnreadInfo (result:(info:RYUnread)->()) {
        
    }
}
