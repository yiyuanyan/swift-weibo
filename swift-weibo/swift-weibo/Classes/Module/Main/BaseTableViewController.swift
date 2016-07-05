//
//  BaseTableViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit
//第四步，另一个类实现VisVistorLoginViewDelegate协议
class BaseTableViewController: UITableViewController,VisVistorLoginViewDelegate {
    
    
    var userLogin = false;
    var userLoginView:VistorLoginView?;
    override func loadView() {
        if(userLogin){
            //用户已经登录
            super.loadView();
            return;
        }
        //用户未登录
        userLoginView = NSBundle.mainBundle().loadNibNamed("VistorLoginView", owner: nil, options: nil).last as? VistorLoginView;
        //设置代理响应者
        userLoginView?.loginDelegate = self;
        view = userLoginView;
        //创建导航栏左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.registerBtnDidClick));
        //设置创建的导航栏按钮的文字颜色
        //navigationController?.navigationBar.tintColor = UIColor.orangeColor();
        //创建导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.loginBtnDidClick));
        
    }
    //实现协议方法
    func loginBtnDidClick() {
        print("登录");
    }
    func registerBtnDidClick() {
        print("注册");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.orangeColor();

        
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

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
