//
//  VistorLoginView.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/4.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit
//第一步，创建代理协议
//定义代理协议，类名Delegate  遵守NSObjectProtocol协议
protocol VisVistorLoginViewDelegate:NSObjectProtocol {
    //定义代理方法
    func loginBtnDidClick()
    //定义代理方法
    func registerBtnDidClick()
}
class VistorLoginView: UIView {
    //第二步，声明代理属性
    //声明代理属性
    weak var loginDelegate:VisVistorLoginViewDelegate?
    
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
    //第三步，调用协议的方法
    @IBAction func LoginAction(sender: AnyObject) {
        //调用协议的方法
        loginDelegate?.loginBtnDidClick();
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        //调用协议的方法
        loginDelegate?.registerBtnDidClick();
    }
    

}
