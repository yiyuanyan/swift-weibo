//
//  VistorLoginView.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/4.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class VistorLoginView: UIView {

    @IBOutlet weak var smallIcon: UIImageView!
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    func setUpUIWithInfo(iconName:String, tipText:String, isHideSmallIcon:Bool = true){
        if !isHideSmallIcon{
            startAnimation();
        }
        smallIcon.hidden = isHideSmallIcon;
        iconView.image = UIImage(named: iconName);
        tipLabel.text = tipText;
    }
    
    func startAnimation(){
        let animation = CABasicAnimation(keyPath: "transform.rotation");
        animation.toValue = 2 * M_PI;
        animation.duration = 15;
        animation.repeatCount = MAXFLOAT;
        animation.removedOnCompletion = false;
        smallIcon.layer.addAnimation(animation, forKey: nil);
    }
    @IBAction func LoginAction(sender: AnyObject) {
        print("登录");
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        print("注册");
    }
    

}
