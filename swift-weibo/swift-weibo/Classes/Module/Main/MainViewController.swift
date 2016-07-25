//
//  MainViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/6/30.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    @IBOutlet weak var MainTabBar: MainTabbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers();
        MainTabBar.composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnDidClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        
    }
    //按钮点击
    func composeBtnDidClick(sender:UIButton){
        print(#function);
        let VC = UIStoryboard.initalViewController("Compose");
        presentViewController(VC, animated: true, completion: nil);
    }
    //添加所有的子视图控制器
    private func addChildViewControllers(){

        
        addChildViewController("Home", title: "首页", imageName: "tabbar_home");
        addChildViewController("Message", title: "消息", imageName: "tabbar_message_center");
        addChildViewController("Discover", title: "发现", imageName: "tabbar_discover");
        addChildViewController("Profile", title: "我的", imageName: "tabbar_profile");
    }
    //创建子视图
    /*
     函数重载，函数名一样，但参数不同
    */
    private func addChildViewController(sbName:String, title:String, imageName:String) {

        let nav = UIStoryboard.initalViewController(sbName) as! UINavigationController;
        //设置导航标题
        nav.topViewController!.title = title;
        //设置tabBar按钮图片
        nav.tabBarItem.image = UIImage(named: imageName);
        //设置tabBar选中图片
        nav.tabBarItem.selectedImage = UIImage(named: imageName + "highlighted");
        
        addChildViewController(nav);
    }


}
