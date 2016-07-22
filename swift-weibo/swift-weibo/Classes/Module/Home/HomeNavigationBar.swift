//
//  HomeNavigationBar.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/22.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class HomeNavigationBar: UINavigationBar {
    lazy var tipLabel: UILabel = {
        let tip = UILabel(frame: CGRectZero);
        tip.textAlignment = NSTextAlignment.Center;
        tip.font = UIFont.systemFontOfSize(14);
        tip.backgroundColor = UIColor.orangeColor();
        tip.textColor = UIColor.orangeColor();
        return tip;
    }()
    override func awakeFromNib() {
        self.insertSubview(tipLabel, atIndex: 0);
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        if (tipLabel.frame == CGRectZero){
            tipLabel.frame = CGRectOffset(bounds, 0, -bounds.height * 2);
        }
    }
    
    func showTipWithAnimation(text:String){
        tipLabel.text = text;
        let rect = tipLabel.frame;
        UIView.animateWithDuration(1.5, animations: {
            self.tipLabel.frame = CGRectOffset(self.bounds, 0, self.bounds.height);
            }) { (_) in
                UIView.animateWithDuration(1, delay: 0.5, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { 
                    self.tipLabel.frame = rect;
                    }, completion: nil)
                
                
        }
    }

}
