//
//  HomeViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/6/30.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    @IBOutlet weak var titleButton: HomtTitleButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginView?.setUpUIWithInfo("visitordiscover_feed_image_house", tipText: "关注一些人，回这里看看有什么惊喜", isHideSmallIcon: false);
        setTitleButton();
        
    }
    private func setTitleButton(){
        if(sharedUserAccount != nil){
            titleButton.setTitle(sharedUserAccount!.name! + " ", forState: UIControlState.Normal);
        }else{
            titleButton.setImage(nil, forState: UIControlState.Normal);
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Home2Popover"){
            let popVC = segue.destinationViewController as! PopOverViewController;
            popVC.transitioningDelegate = self;
            //设置展现方式
            popVC.modalPresentationStyle = UIModalPresentationStyle.Custom;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    var isPresentation = false;

}
//继承
extension HomeViewController:UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning{
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        return PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting);
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
