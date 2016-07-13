//
//  User.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

import Foundation

class User: NSObject {
    //用户UID
    var id:Int = 0;
    //yonghu youhaoxianshi mingcheng 
    var name:String?
    //用户头像
    var profile_image_url:String?{
        didSet{
            profile_imageURL = NSURL(string: profile_image_url!);
        }
    }
    //
    var profile_imageURL: NSURL?
    
    private static var properties = ["id","name","profile_image_url"];
    
    init(dict:[String:AnyObject]){
        super.init();
        for key in User.properties{
            if dict[key] == nil{
                continue
            }
            setValue(dict[key], forKey: key);
        }
    }
    
    
}
