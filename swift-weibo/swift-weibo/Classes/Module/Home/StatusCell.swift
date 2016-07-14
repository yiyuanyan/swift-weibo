//
//  StatusCell.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet weak var pictureViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var pictureViewWidth: NSLayoutConstraint!
    @IBOutlet weak var pictureView: UICollectionView!
    
    @IBOutlet weak var pictureViewLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var status:Status?{
        didSet{
            iconImage.sd_setImageWithURL(status?.user?.profile_imageURL, placeholderImage: UIImage(named: "avatar_default_bigs"))
            nameLabel.text = status!.user?.name;
            timeLabel.text = status?.created_at;
            sourceLabel.text = status?.source;
            contentLabel.text = status?.text;
            let p = calcPictureViewSize(status!);
            pictureViewHeight.constant = p.viewSize.height;
            pictureViewWidth.constant = p.viewSize.width;
            pictureViewLayout.itemSize = p.itemSize;
            pictureView.reloadData();
        }
    }
    private func calcPictureViewSize(status: Status) -> (viewSize:CGSize, itemSize:CGSize){
        //单张图片默认大小
        let s: CGFloat = 90;
        let itemSize = CGSizeMake(s, s);
        let m:CGFloat = 10;
        let imageCount = status.pictureURLs?.count ?? 0;
        if imageCount == 0 {
            return (CGSizeZero,CGSizeZero);
        }
        if imageCount == 1{
            //从缓存中获取图片
            let key = status.pictureURLs![0].absoluteString;
            
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key);
            return (image.size,image.size);
            
        }
        if imageCount == 4{
            print("四张图片");
            
            return (CGSizeMake(s * 2 + m, s * 2 + m), itemSize);
        }
        let row = CGFloat((imageCount - 1)/3 + 1);
        return (CGSizeMake(s * 3 + m * 2, s * row + (row - 1) * m), itemSize);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置label的最大宽度值
        contentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20;
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension StatusCell:UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.pictureURLs?.count ?? 0;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PictureCell", forIndexPath: indexPath) as! PictureCell;
        cell.url = status!.pictureURLs![indexPath.item];
        
        return cell;
        
    }
}

class PictureCell:UICollectionViewCell{
    @IBOutlet weak var iconView: UIImageView!
    var url: NSURL?{
        didSet{
            iconView.sd_setImageWithURL(url);
        }
    }
}
