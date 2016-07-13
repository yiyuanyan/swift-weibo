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
