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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //快速判断是否为空，为空则返回0
        return statuses?.count ?? 0;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell")! as! StatusCell;
        cell.status = statuses![indexPath.row];
        
        return cell;
    }
    

}


