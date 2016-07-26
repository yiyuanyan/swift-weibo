//
//  PictureSelectCell.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class PictureSelectCell: UICollectionViewCell {
    @IBAction func selectedPicture(sender:AnyObject){
        //接收通知方法
        NSNotificationCenter.defaultCenter().postNotificationName(WBPictureSelectedNotification, object: self);
    }
    @IBAction func removePicture(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(WBPictureRemoveNotification, object: self);
    }
    override func awakeFromNib() {
        
    }
}
