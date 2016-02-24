//
//  EmoticonTextView.swift
//  EmoticonKeyboard
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class EmoticonTextView: UITextView {

    func insetText(em: Emoticon) {
        //在这里面智能提示 会好一点
        if em.isEmpty {
            print("点击的是空表情")
            return
        }
        
        if em.isDelete {
            //回删的操作
            deleteBackward()
            return
        }
        
        if em.code != nil {
            //点击的是 emoji表情
            replaceRange(selectedTextRange!, withText: em.emojiStr ?? "")
            return
        }
        
        
        //点击的是图片
        //如何将图片输入到 textView当中
        //附件类
        let imageText = EmoticonTextAttachment.emoticonImageToAttributeString(em, font: font!)
        
        //在替换前记录之前选中的位置
        let range = selectedRange
        //3.将包含的图片的属性字符串 替换到 textView.attributeText
        let strM = NSMutableAttributedString(attributedString: attributedText)
        
        //4.替换属性字符串
        strM.replaceCharactersInRange(selectedRange, withAttributedString: imageText)
        
        //5.设置属性字符串
        attributedText = strM
        
        //6.恢复光标位置
        selectedRange = NSRange(location: range.location + 1, length: 0)
        
        //主动使用代理调用协议方法
        delegate?.textViewDidChange?(self)
        
    }
    
    
    //将属性文本转换为 纯文本
    func fullText() -> String {
        
        var strM = String()
        attributedText.enumerateAttributesInRange(NSRange(location: 0, length:attributedText.length), options: []) { (dict, range, _) -> Void in
            //            print(dict)
            //            print("============")
            //            print(range)
            //如果属性中包含了 NSAttachment这个key 就意味中 是图片
            if let attachment = dict["NSAttachment"] as? EmoticonTextAttachment {
                //                print("表情图片")
                //怎么获取对应图片文本
                //                print(attachment.chs)
                strM += (attachment.chs ?? "")
            } else {
                //                print("纯文本")
                let subStr = (self.text as NSString).substringWithRange(range)
                strM += subStr
            }
            
        }
        
        return strM
    }

}
