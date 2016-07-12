//
//  PopoverPresentationController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    var presentedViewFrame:CGRect = CGRectZero;
    lazy var dummyView: UIView = {
        let v = UIView();
        v.backgroundColor = UIColor(white: 0.0, alpha: 0.3);
        let tap = UITapGestureRecognizer(target: self, action: #selector(PopoverPresentationController.clickDummyView));
        v.addGestureRecognizer(tap);
        return v;
    }()
    func clickDummyView(){
        self.presentedViewController.dismissViewControllerAnimated(true, completion: nil);
    }
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController);
    }
    override func containerViewDidLayoutSubviews() {
        presentedView()!.frame = presentedViewFrame;
        dummyView.frame = containerView!.bounds;
        containerView!.insertSubview(dummyView, atIndex: 0);
    }
}
