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
    //上传图片方法
    class func uploadImage(urlString:String,  status:String, imageData:NSData){
        upload(
            .POST,
            urlString,
            multipartFormData: { multipartFormData in
                //将所有的参数转换成Data数据
                var statusData = status.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true);
                var tokenData = sharedUserAccount!.access_token?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true);
                // data:上传的数据，name:服务器对应字段 fileName:文件上传到服务器对应的名称，后台要是重新修改可随便写
                multipartFormData.appendBodyPart(data: statusData!, name: "status");
                multipartFormData.appendBodyPart(data: tokenData!, name: "access_token");
                multipartFormData.appendBodyPart(data: imageData, name: "pic", fileName: "wbpic", mimeType: "image/jpeg");
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        //上传成功
                        SVProgressHUD.showInfoWithStatus("图片上传成功");
                        debugPrint(response)
                    }
                case .Failure(let encodingError):
                    //上传失败
                    SVProgressHUD.showInfoWithStatus("图片上传失败");
                    print(encodingError)
                }
            }
        )
    }
}
