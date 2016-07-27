//
//  PictureSelectCell.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class PictureSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureButton: UIButton!
    
    @IBOutlet weak var removeButton: UIButton!
    var image:UIImage?{
        didSet{
            removeButton.hidden = (image == nil)
            if image != nil{
                pictureButton.setImage(image, forState: UIControlState.Normal);
            }else{
                pictureButton.setImage(UIImage(named: "compose_pic_add"), forState: UIControlState.Normal);
            }
        }
    }
    
    @IBAction func selectedPicture(sender:AnyObject){
        if image != nil{
            print("图片已存在");
            return;
        }
        //接收通知方法
        NSNotificationCenter.defaultCenter().postNotificationName(WBPictureSelectedNotification, object: self);
    }
    @IBAction func removePicture(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(WBPictureRemoveNotification, object: self);
    }
    override func awakeFromNib() {
        pictureButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill;
    }
    
}
