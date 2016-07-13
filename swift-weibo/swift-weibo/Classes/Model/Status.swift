//
//  Status.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit
private let WB_STATUS = "https://api.weibo.com/2/statuses/friends_timeline.json";
class Status: NSObject {
    //微博创建时间
    var created_at:String?;
    //微博ID
    var id:Int = 0;
    
    //微博内容
    var text:String?;
    //微博来源
    var source:String?;
    //缩略图数组
    var pic_urls:[[String:String]]?{
        didSet{
            imageURLs = [NSURL]();
            for dict in pic_urls!{
                let urlString = dict["thumbnail_pic"];
                let url = NSURL(string: urlString!);
                if(url != nil){
                    imageURLs?.append(url!);
                }
            }
        }
    }
    
    
    var imageURLs:[NSURL]?;
    var user:User?
    
    private static var properties = ["created_at","id","text","source","pic_urls", "user"];
    class func loadStatus(completion:(statuses:[Status]?) ->()){
        let params = ["access_token":sharedUserAccount!.access_token! as String];
        NetworkTools.requestJSON(.GET, URLString: WB_STATUS, parameters: params) { (JSON) in
            if(JSON == nil){
                print("请求失败");
                completion(statuses: nil);
                return;
            }
            //print(JSON.result.value);
            let array = (JSON as! NSDictionary)["statuses"] as? [[String:AnyObject]];
            if(array != nil){
                let items = Status.statuses(array!);
                Status.cacheStatusImage(items);
                //completion(statuses:items);
            }
            
        }
        
        
        
    }
    //缓存图片
    private class func cacheStatusImage(statuses:[Status]?){
        if(statuses == nil){
            return;
        }
        //便利数组
        for s in statuses as [Status]!{
            if(s.imageURLs == nil){
                continue;
            }else{
                let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as String;
                for url in s.imageURLs!{
                    SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions.CacheMemoryOnly, progress: nil, completed: { (_, _, _, _, _) in
                        
                    })
                }
            }
        }
    }
    private class func statuses(array:[[String:AnyObject]]) -> [Status]?{
        //便利数据
        var arrayM = [Status]();
        for dict in array{
            //字典转模型
            let status = Status(dict: dict);
            arrayM.append(status);
        }
        return arrayM;
    }
    //字典转模型方法
    init(dict:[String:AnyObject]){
        super.init();
        for key in Status.properties{
            if dict[key] == nil{
                continue;
            }
            setValue(dict[key], forKeyPath: key);
        }
        let userDict = dict["user"] as? [String:AnyObject];
        if(userDict != nil){
            user = User(dict: userDict!);
        }
    }
}
