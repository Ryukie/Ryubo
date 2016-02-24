//
//  EmoticonTextAttachment.swift
//  EmoticonKeyboard
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class EmoticonTextAttachment: NSTextAttachment {
    //表情图片对应的文本
    var chs: String?
    
    
    //将表情图片转换为包含附件的属性文本
    class func emoticonImageToAttributeString(em: Emoticon, font: UIFont) -> NSMutableAttributedString {
        //附件类
        let attachment = EmoticonTextAttachment()
        attachment.chs = em.chs
        //设置附件的大小
        let lineHeight = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        //1.给附件设置图片
        attachment.image = UIImage(contentsOfFile: em.imagePath ?? "")
        //2.如何将附件给替换到 文本中 需要使用到 富文本(属性文本)
        //将附件添加到属性字符串中
        //2.1将附件添加到属性字符串中
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        
        //2.2给属性文本设置属性
        imageText.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: 1))
        
        return imageText
    }
}
