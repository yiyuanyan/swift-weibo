//
//  HomtTitleButton.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class HomtTitleButton: UIButton {

    //修改内部子视图的frame
    override func layoutSubviews() {
        super.layoutSubviews();
        if(titleLabel?.text == "首页"){
            return;
        }
        
        titleLabel!.frame = CGRectOffset(titleLabel!.frame, -imageView!.frame.size.width, 0);
        imageView!.frame = CGRectOffset(imageView!.frame, titleLabel!.frame.size.width, 0);
    }

}
