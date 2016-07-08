//
//  OAuthViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/6.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    let authUrlString = "https://api.weibo.com/oauth2/authorize";
    let client_id = "3307873177";
    let client_secret = "83ab0fd6f01ffc3f237cf25c3b21516e";
    let redirect_uri = "www.hejianxin.com";
    var webView: UIWebView?{
        return view as? UIWebView;
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAppCode();
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(animated: Bool) {
        SVProgressHUD.dismiss();
    }
    private func loadAppCode(){
        //拼接连接
        let urlString = authUrlString + "?client_id=" + client_id + "&redirect_uri=" + redirect_uri + "&display=mobile";
        //将字符串转为NSURL
        let url = NSURL(string: urlString);
        //发送请求
        let request = NSURLRequest(URL: url!);
        //用webView加载返回来的web内容
        webView?.loadRequest(request);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show();
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss();
    }
    //一般 协议方法  返回值为BOOL   如果返回值为true当前视图就可以正常工作，否则不能进行后续操作
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.URL;
        let urlString = url!.absoluteString;
        if(urlString.hasPrefix(authUrlString)){
            return true;
        }
        //获取code码
        let codeStr = "code=";
        //截取出参数，过滤掉主机名、域名和host
        let query = url!.query;
        if(query!.hasPrefix(codeStr)){
            let code = (query! as NSString).substringFromIndex(codeStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding));
            //使用code请求令牌token
            loadAccesstoken(code);
        }
        return true;
    }
    
    private func loadAccesstoken(code:String){
        //拼装所需要的属性
        let parmas = ["client_id":client_id,"client_secret":client_secret,"grant_type":"authorization_code","code":code,"redirect_uri":redirect_uri];
        //类方法调用
        UserAccount.loadAccessToken(parmas) { (userAccount) in
            if(userAccount != nil){
                sharedUserAccount = userAccount
                SVProgressHUD.showSuccessWithStatus("登录成功");
                self.close();
//                let sb = UIStoryboard(name: "WelCome", bundle: nil);
//                let VC = sb.instantiateInitialViewController()! as UIViewController;
//                UIApplication.sharedApplication().keyWindow?.rootViewController = VC;
                NSNotificationCenter.defaultCenter().postNotificationName(WBSwitchRootVC, object: "WelCome");
            }else{
                SVProgressHUD.showErrorWithStatus("未登录");
                
            }
        };
        
        
    }
    
    

}
