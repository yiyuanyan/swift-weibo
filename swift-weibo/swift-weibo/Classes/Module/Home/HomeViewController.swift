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
        Status.loadStatus();
        
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
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    

}

