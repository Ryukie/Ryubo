//
//  UIButton+Extension.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/16.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

extension UIButton {
    /**
     仅有背景图和图片-加号按钮
     */
    convenience init (backgroundImageName:String,imageName:String) {
        self.init()
        setBackgroundImage(UIImage(named:  backgroundImageName), forState: .Normal)
        setBackgroundImage(UIImage(named:  backgroundImageName + "_highlighted"), forState: .Highlighted)
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        sizeToFit()
    }
    /**
    *  含有背景图及文案-登录注册按钮
    */
    convenience init (backgroundImageName:String?,titleText:String,textFont:CGFloat,textColor:UIColor,imageName:String?) {
        self.init()
        
        if backgroundImageName != nil {
            let image = UIImage(named: backgroundImageName!)!
            let edg:UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            setBackgroundImage(image.resizableImageWithCapInsets(edg), forState: .Normal)
        }
        if imageName != nil {
            setImage(UIImage(named: imageName!), forState: .Normal)
        }
        setTitle(titleText, forState: .Normal)
        setTitleColor(textColor, forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(textFont)
        titleLabel?.textAlignment = .Center
        sizeToFit()
    }

    
    
    
    
}
