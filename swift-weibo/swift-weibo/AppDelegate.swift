//
//  AppDelegate.swift
//  swift-weibo
//
//  Created by 何建新 on 16/6/30.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit
var sharedUserAccount = UserAccount.loadUserAccount();
//切换根视图控制器的通知
let WBSwitchRootVC = "WBSwitchRootVC";


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //手动初始化WINDOW
        window = UIWindow(frame: UIScreen.mainScreen().bounds);
        window?.makeKeyAndVisible();
        window?.backgroundColor = UIColor.whiteColor();
        
        //设置全局导航栏按钮颜色
        setThemeColor();
        //定义一个通知   自身   通知响应的方法  定义的常量
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.switchRootViewController), name: WBSwitchRootVC, object: nil);

        showMainInterface();

        return true
    }
    //通知响应的类。
    func switchRootViewController(notification:NSNotification){
        print(notification.object);
//        let sb = UIStoryboard(name: "WelCome", bundle: nil);
//        let VC = sb.instantiateInitialViewController()! as UIViewController;
//        UIApplication.sharedApplication().keyWindow?.rootViewController = VC;
        let sbName = notification.object as! String;
        showStoryBoard(sbName);
        
    }
    private func setThemeColor(){
        UINavigationBar.appearance().tintColor = UIColor.orangeColor();
        UITabBar.appearance().tintColor = UIColor.orangeColor();
    }
    
    private func isNeedUpdate() -> Bool{
        //获取当前版本
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String;
        //将字符串转换为double数字
        let versionNum = NSNumberFormatter().numberFromString(currentVersion)!.doubleValue;
        //获取沙盒中的版本
        let sandBoxKey = "update";
        let defaults = NSUserDefaults.standardUserDefaults();
        let sandBoxVersion = defaults.doubleForKey(sandBoxKey);
        //立即存储版本号
        defaults.setDouble(versionNum, forKey: sandBoxKey);
        defaults.synchronize();
        return (versionNum > sandBoxVersion);
    }
    private func showMainInterface(){
        var sbName = "Main";
        
        if sharedUserAccount != nil {
            //用户已经登录
            if(isNeedUpdate()){
                sbName = "NewFeature";
            }else{
                sbName = "WelCome";
            }
        }
        showStoryBoard(sbName);
        
    }
    private func showStoryBoard(sbName:String){
        let sb = UIStoryboard(name: sbName, bundle: nil);
        let VC = sb.instantiateInitialViewController()! as UIViewController;
        window?.rootViewController = VC;
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

