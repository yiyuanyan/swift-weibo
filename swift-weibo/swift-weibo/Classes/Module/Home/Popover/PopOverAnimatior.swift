//
//  PopOverAnimatior.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class PopOverAnimatior: NSObject,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    var presentedViewFrame:CGRect = CGRectZero;
    var isPresentation = false;
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        let presentationC = PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting);
        presentationC.presentedViewFrame = presentedViewFrame;
        return presentationC;
    }
    //展现动画效果
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresentation = true;
        return self;
    }
    //消失动画效果
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresentation = false;
        return self;
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5;
    }
    /*
     transitionContext:转上上下文 提供专场动画的相关信息。
     包含从哪里来，到哪里去
     主要提供专场动画。实现这个方法，系统动画就会失效
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        if(isPresentation){
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey);
            
            
            transitionContext.containerView()!.addSubview(toView!);
            toView!.transform = CGAffineTransformMakeScale(1, 0);
            toView!.layer.anchorPoint = CGPointMake(0.5, 0);
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions.LayoutSubviews, animations: {
                toView!.transform = CGAffineTransformMakeScale(1, 1);
            }) { (_) in
                //动画结束
                transitionContext.completeTransition(true);
            }
        }else{
            //窗口消失的代码
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey);
            fromView?.removeFromSuperview();
            
            transitionContext.completeTransition(true);
        }
    }
}
