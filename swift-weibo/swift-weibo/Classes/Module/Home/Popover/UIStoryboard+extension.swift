//
//  UIStoryboard+extension.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit
extension UIStoryboard{
    class func initalViewController(sbName:String) ->UIViewController{
        let sb = UIStoryboard(name: sbName, bundle: nil);
        return sb.instantiateInitialViewController()! as UIViewController;
    }
}