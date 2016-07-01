//
//  MainTabbar.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class MainTabbar: UITabBar {
    //通过重写layoutSubviews设置subviews的frame
    override func layoutSubviews() {
        //需要调用super的方法
        super.layoutSubviews();
        let h = self.bounds.height;
        let w = self.bounds.width / 5;
        let frame = CGRectMake(0, 0, w, h);
        var index = 0;
        for view in subviews as! [UIView] {
            if view is UIControl && !(view is UIButton){
                view.frame = CGRectOffset(frame, CGFloat(index) * w, 0);
//                if index == 1{
//                    index += 1;
//                }
//                index += 1;
                //效果同上
                index += (index == 1) ? 2 : 1;
            }
        }
        composeBtn.frame = CGRectOffset(frame, 2 * w, 0);
    }
    //懒加载
    lazy var composeBtn:UIButton = {
        //调用button的默认初始化方法，得到的是一个自定义样式的按钮
        let btn = UIButton();
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal);
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: UIControlState.Normal);
        //设置高亮模式
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted);
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted);
        self.addSubview(btn);
        return btn;
    }()
    
    

}
