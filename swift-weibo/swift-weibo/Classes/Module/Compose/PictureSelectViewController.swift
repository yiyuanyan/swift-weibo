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
    //记录图片数组
    var pictureList = [UIImage]();
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
        //UIImagePickerController是苹果提供的照片选择类
        /*
         case PhotoLibrary  图片库
         case Camera  相机
         case SavedPhotosAlbum 保存的照片
        */
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            print("不支持访问相册");
            return;
        }
        //可以选择照片
        //选取照片 实例化一个picker
        let picker = UIImagePickerController();
        //设置选择照片的模式。
        //picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
        //谁知代理 获取选择的照片,要遵守UIImagePickerControllerDelegate协议
        picker.delegate = self;
        //允许照片被编辑
        //picker.allowsEditing = true;
        presentViewController(picker, animated: true, completion: nil);
        
    }
    func removePicture(notification:NSNotification){
        print(#function);
        //从通知中获取cell
        let cell = notification.object as! PictureSelectCell;
        //获取cell的indexPath
        if let indexPath = collectionView?.indexPathForCell(cell){
            //移除图片数组指定的图片元素
            pictureList.removeAtIndex(indexPath.item)
            //刷新数据
            collectionView?.reloadData();
        }
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
        return pictureList.count + 1;
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PictureSelectCell", forIndexPath: indexPath) as! PictureSelectCell;
        //防止数组越界
        print("indexPath.item = \(indexPath.item) ---- indexPath.row = \(indexPath.row)");
        if indexPath.item < pictureList.count{
            cell.image = pictureList[indexPath.item];
        }else{
            cell.image = nil;
        }
        // Configure the cell
    
        return cell
    }

    

}
//继承协议，实现协议方法
extension PictureSelectViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        //图片路径
        print(image);
        //获取的图片添加到数组中
        pictureList.append(image);
        //刷新数据
        collectionView?.reloadData();
        //图片信息
        print(editingInfo);
        //一点实现了选取图片协议方法，应该手动dismiss
        dismissViewControllerAnimated(true, completion: nil);
    }
}
