//
//  PictureSelectViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "PictureSelectCell"
//定义通知名称
let WBPictureSelectedNotification = "WBPictureSelectedNotification";
let WBPictureRemoveNotification = "WBPictureRemoveNotification";

class PictureSelectViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //调用通知方法
        regNotificastion();
        
    }
    //添加通知
    private func regNotificastion(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PictureSelectViewController.selectPicture(_:)), name: WBPictureSelectedNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PictureSelectViewController.removePicture(_:)), name: WBPictureRemoveNotification, object: nil);
    }
    //必须有解除通知方法
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    //实现通知方法
    func selectPicture(notification:NSNotification){
        print(#function);
    }
    func removePicture(notification:NSNotification){
        print(#function);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PictureSelectCell", forIndexPath: indexPath) as! PictureSelectCell;
        
        // Configure the cell
    
        return cell
    }

    

}
