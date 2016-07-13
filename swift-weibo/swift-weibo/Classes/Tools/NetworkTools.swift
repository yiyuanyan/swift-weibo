//
//  NetworkTools.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class NetworkTools: NSObject {
    class func requestJSON(method: Method, URLString: String, parameters: [String: AnyObject]? = nil, completion:(JSON:AnyObject?)->()){
        request(method, URLString, parameters: parameters).responseJSON { (JSON) in
            if(JSON.result.error != nil){
                print("Error:\(JSON.result.error)");
                //回调方法。
                completion(JSON:nil);
                SVProgressHUD.showErrorWithStatus("网络连接错误");
                return;
            }
            //请求成功
            completion(JSON:JSON.result.value);
            
        }
    }
}
