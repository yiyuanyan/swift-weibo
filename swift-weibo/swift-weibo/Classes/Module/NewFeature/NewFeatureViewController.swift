//
//  NewFeatureViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/7.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NewFeatureCell"

class NewFeatureViewController: UICollectionViewController {

    @IBOutlet weak var NewFeatureLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        NewFeatureLayout.itemSize = self.view.frame.size;
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
    
    let imageCount = 4;
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageCount;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
        cell.imageIndex = indexPath.item;
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let path = collectionView.indexPathsForVisibleItems().last! as NSIndexPath;
        let lastCell = collectionView.cellForItemAtIndexPath(path) as! NewFeatureCell;
        //如果是最后一个cell
        if(path.item == imageCount-1){
            lastCell.showStartBtnWithAnimation();
        }
    }

}


class NewFeatureCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var startBtn: UIButton!
    
    var imageIndex = 0{
        didSet{
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)");
            if(imageIndex == 3){
                
                //showStartBtnWithAnimation();
            }
        }
    }
    
    func showStartBtnWithAnimation(){
        startBtn.hidden = false;
        //设置按钮的大小为0
        startBtn.transform = CGAffineTransformMakeScale(0, 0);
        /*
         开启动画效果
         参数：动画执行时间，‘’，弹簧系数，加速度，动画样式，动画执行时闭包方法，动画结束后闭包方法
        */
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, options: UIViewAnimationOptions.LayoutSubviews, animations: {
            //讲按钮大小设置为初始状态
            self.startBtn.transform = CGAffineTransformMakeScale(1, 1);
            }) { (_) in
                print("OK");
        }
    }
    
    @IBAction func startBtnDidClick(sender: AnyObject) {
//        let sb = UIStoryboard(name: "Main", bundle: nil);
//        let VC = sb.instantiateInitialViewController()! as UIViewController;
//        UIApplication.sharedApplication().keyWindow?.rootViewController = VC;
        NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootVC, object: "Main");
    }
    
    
}
