//
//  RYHomeCell.swift
//  Ryubo
//
//  Created by 王荣庆 on 16/2/17.
//  Copyright © 2016年 Ryukie. All rights reserved.
//

import UIKit

class RYHomeCell: UITableViewCell {
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpSubviews()
    }
// MARK: - 添加子控件
    private func setUpSubviews () {
        self.backgroundColor = UIColor.grayColor()
    }
// MARK: - 布局子控件
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
