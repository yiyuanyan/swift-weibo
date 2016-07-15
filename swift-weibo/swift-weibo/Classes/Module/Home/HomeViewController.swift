//
//  HomeViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/6/30.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit
class HomeViewController: BaseTableViewController {
    var rowHeightCache = NSCache();
    @IBOutlet weak var titleButton: HomtTitleButton!
    //当这个数据被赋值后调用方法
    var statuses:[Status]?{
        didSet{
            
            tableView.reloadData();
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginView?.setUpUIWithInfo("visitordiscover_feed_image_house", tipText: "关注一些人，回这里看看有什么惊喜", isHideSmallIcon: false);
        setTitleButton();
        if(userLogin){
            loadData();
        }
        
    }
    private func loadData(){
        Status.loadStatus { (statuses) in
            self.statuses = statuses;
        }
    }
    private func setTitleButton(){
        if(sharedUserAccount != nil){
            titleButton.setTitle(sharedUserAccount!.name! + " ", forState: UIControlState.Normal);
        }else{
            titleButton.setImage(nil, forState: UIControlState.Normal);
        }
    }
    let popoverDelegate = PopOverAnimatior();
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Home2Popover"){
            let popVC = segue.destinationViewController as! PopOverViewController;
            popVC.transitioningDelegate = popoverDelegate;
            popoverDelegate.presentedViewFrame = CGRectMake((self.view.bounds.width - 200)/2, 64, 200, 240);
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
        return 1;
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) -> CGFloat{
        //使用微博ID作为KEY进行存取
        
        let status = statuses![indexPath.row];
        //判断是否已经有缓存的行高
        if (rowHeightCache.objectForKey(status.id) != nil){
            print("返回缓存行高");
            return rowHeightCache.objectForKey(status.id) as! CGFloat;
        }
        //当没有渠道缓存行高的时候
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusCell.cellIdentifer(status)) as! StatusCell;
        let height = cell.rowHeight(status);
        //保存行高到cache
        rowHeightCache.setObject(height, forKey: status.id);
        print("计算行高:\(height)");
        return height;
    }
    //预估行高
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //快速判断是否为空，为空则返回0
        return statuses?.count ?? 0;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let status = statuses![indexPath.row];
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusCell.cellIdentifer(status))! as! StatusCell;
        cell.status = statuses![indexPath.row];
        
        return cell;
    }

    

}


