//
//  UserAccount.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/6.
//  Copyright © 2016年 何建新. All rights reserved.
//  网络请求回来的用户数据保存在这个模型中

import UIKit

class UserAccount: NSObject, NSCoding {
    var access_token: String?
    var expires_in: NSTimeInterval = 0;
    var expires_date: NSDate?
    var uid: String?
    static let accountPaht = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! as String).stringByAppendingString("/account.plist");
    //自定义初始化方法
    init(dict:[String:AnyObject]) {
        access_token = dict["access_token"] as? String;
        expires_in = (dict["expires_in"] as? NSTimeInterval)!;
        expires_date = NSDate(timeIntervalSinceNow: expires_in);
        uid = dict["uid"] as? String;
    }
    
    //类方法。其他类中和直接类名.方法名调用
    class func loadAccessToken(parmas:[String:AnyObject],completion:(userAccount: UserAccount?) -> ()){
        //使用Alamofire框架发送网络请求
        request(.POST, "https://api.weibo.com/oauth2/access_token", parameters: parmas).responseJSON { JSON in
            //返回失败
            if(JSON.result.isFailure){
                //打印错误信息
                print(JSON.result.error);
                completion(userAccount: nil);
                return;
            }
            //返回成功
            if(JSON.result.isSuccess){
                //保存数据
                let userAccount = UserAccount(dict: JSON.result.value as! [String : AnyObject]);
                //将自定义对象进行归档的操作，保存到本地
                //print(UserAccount.accountPaht);
                NSKeyedArchiver.archiveRootObject(userAccount, toFile: UserAccount.accountPaht);
                completion(userAccount: userAccount);
            }
        };
    }
    override var description:String{
        let properties = ["access_token","expires_date","uid"];
        return "\(dictionaryWithValuesForKeys(properties))";
    }
    //归档方法，要遵守NSCodeing协议
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token");
        aCoder.encodeDouble(expires_in, forKey: "expires_in");
        aCoder.encodeObject(expires_date, forKey: "expires_date");
        aCoder.encodeObject(uid, forKey: "uid");
    }
    //解析归档方法
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String;
        expires_in = aDecoder.decodeDoubleForKey("expires_in") as NSTimeInterval;
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate;
        uid = aDecoder.decodeObjectForKey("uid") as? String;
    }
    
    //对外调用信息接口
    class func loadUserAccount() -> UserAccount?{
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.accountPaht) as? UserAccount{
            //判断token是否过期
            if(account.expires_date!.compare(NSDate()) == NSComparisonResult.OrderedDescending){
                return account;
            }
            
        }
        
        
        
        return nil;
    }
    
}
