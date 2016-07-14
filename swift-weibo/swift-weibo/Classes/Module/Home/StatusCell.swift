//
//  StatusCell.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

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
        }
    }
    private func calcPictureViewSize() -> CGSize{
        //单张图片默认大小
        let s: CGFloat = 90;
        let itemSize = CGSizeMake(s, s);
        let m:CGFloat = 10;
        let imageCount = status?.imageURLs?.count ?? 0;
        if imageCount == 0 {
            return CGSizeZero;
        }
        if imageCount == 1{
            //从缓存中获取图片
            let key = status?.imageURLs![0].absoluteString;
            
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key);
            return image.size;
            
        }
        if imageCount == 4{
            print("四张图片");
            
            return CGSizeMake(s * 2 + m, s * 2 + m);
        }
        let row = CGFloat((imageCount - 1)/3 + 1);
        return CGSizeMake(s * 3 + m * 2, s * row + (row - 1) * m);
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
