//
//  StatusCell.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet weak var recontentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
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
            //recontentLabel.text = ("@" + (status?.retweeted_status?.user?.name)! ?? "") + ":" + (status?.retweeted_status?.text ?? "");
            
            if(status?.retweeted_status?.text != nil){
                recontentLabel.text = "@" + (status?.retweeted_status?.user?.name)! + ":" + (status?.retweeted_status?.text)!;
            }
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
            return (CGSizeZero,itemSize);
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
    func rowHeight(status: Status) -> CGFloat{
        //设置微博数据，获取数据模型数据
        self.status = status;
        //设置cell的强制更新,设置后视图排版已完成
        self.layoutIfNeeded();
        
        //返回最后一个view的Y
        return CGRectGetMaxY(bottomView.frame);
    }
    //根据数据来获取准确可重用标识符
    class func cellIdentifer(status:Status) -> String{
        if(status.retweeted_status != nil){
            return "RetweetedCell";
        }
        return "HomeCell";
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置label的最大宽度值
        contentLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20;
        
        
            recontentLabel?.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20;
        
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
