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
    var pic_urls:[[String:String]]?;
    static var properties = ["created_at","id","text","source","pic_urls"];
    class func loadStatus(){
        let params = ["access_token":sharedUserAccount!.access_token! as String];
        request(.GET, WB_STATUS, parameters: params).responseJSON { (JSON) in
            if ((JSON.result.value) != nil){
                //print(JSON.result.value);
                let array = (JSON.result.value as! NSDictionary)["statuses"] as? [[String:AnyObject]];
                if(array != nil){
                    let statuses = Status.statuses(array!);
                    for status in statuses!{
                        print(status);
                    }
                }
            }else{
                return;
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
    }
}
