//
//  WelComeViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class WelComeViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        iconView.layer.cornerRadius = 45;
        iconView.layer.masksToBounds = true;
        if let urlString = sharedUserAccount?.avatar_large{
            
            iconView.sd_setImageWithURL(NSURL(string: urlString));
        }
    }
    
    //动画相关代码不要放在viewWillAppear方法中
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.LayoutSubviews, animations: {
            //1.修改头像视图的底部约束
            self.bottomConstraint.constant = self.view.frame.size.height - self.bottomConstraint.constant;
            //2/强制更新动画
            self.view.layoutIfNeeded();
            }) { (_) in
                print("动画完成");
                UIView.animateWithDuration(0.5, animations: { 
                    self.welcomeLabel.alpha = 1.0;
                    }, completion:{ (_) in
//                        let sb = UIStoryboard(name: "Main", bundle: nil);
//                        let VC = sb.instantiateInitialViewController()! as UIViewController;
//                        UIApplication.sharedApplication().keyWindow?.rootViewController = VC;
                        //发送通知类进行通知发送
                        NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootVC, object: "Main");
                })
                
        }
    }

    

}
