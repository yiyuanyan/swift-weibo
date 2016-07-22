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
    //如果转发，原创就不允许有配图 被转发的菜允许有图片
    var pictureURLs:[NSURL]?{
        if(retweeted_status == nil){
            return imageURLs;
        }else{
            return retweeted_status?.imageURLs;
        }
    }
    
    var user:User?
    //转发微博字段
    var retweeted_status: Status?
    
    
    
    private static var properties = ["created_at","id","text","source","pic_urls", "user","retweeted_status"];
    class func loadStatus(since_id: Int,max_id: Int, completion:(statuses:[Status]?) ->()){
        
        var params = ["access_token":sharedUserAccount!.access_token! as String];
        if since_id > 0{
            params["since_id"] = "\(since_id)";
        }
        if max_id > 0{
            params["max_id"] = "\(max_id - 1)";
        }
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
                Status.cacheStatusImage(items, completion: completion);
                //completion(statuses:items);
            }
            
        }
        
        
        
    }
    //缓存图片
    private class func cacheStatusImage(statuses:[Status]?, completion:(statuses:[Status]?) ->()){
        if(statuses == nil){
            completion(statuses: nil);
            return;
        }
        //建立一个dispatch_group 可以监听一组异步完成后 得到统一的通知
        let group  = dispatch_group_create();
        //便利数组
        for s in statuses as [Status]!{
            if(s.pictureURLs == nil){
                continue;
            }else{
                let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as String;
                for url in s.pictureURLs!{
                    //建立群组
                    dispatch_group_enter(group);
                    SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions.CacheMemoryOnly, progress: nil, completed: { (_, _, _, _, _) in
                        //离开群组 一定要放在block的最后一句，表示异步任务全部完成
                        dispatch_group_leave(group);
                        
                    })
                }
            }
        }
        //监听群组的调度结果
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            print("所有图片下载完成");
            completion(statuses: statuses);
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
        //实例化转发微博
        if let retweetedDict = dict["retweeted_status"] as? [String:AnyObject]{
            retweeted_status = Status(dict:retweetedDict);
        }
    }
}
