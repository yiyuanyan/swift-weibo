//
//  ComposeViewController.swift
//  swift-weibo
//
//  Created by 何建新 on 16/6/30.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController,UITextViewDelegate {
    var maxStatusLength = 140;

    @IBOutlet weak var sendBarItem: UIBarButtonItem!
    
    @IBOutlet weak var pictureViewHeightContraint: NSLayoutConstraint!
    
    
    var pictureSelectVC: PictureSelectViewController?
    
    @IBOutlet weak var toolBarBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    lazy var placeHolderLabel:UILabel = {
        let l = UILabel(frame: CGRectMake(5,8,0, 0));
        l.text = "分享新鲜事儿...";
        l.font = UIFont.systemFontOfSize(18);
        l.textColor = UIColor.lightGrayColor()
        l.sizeToFit();
        return l;
    }()
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    @IBAction func sendStatus(sender: AnyObject) {
        let statusText = textView.text;
        if statusText.characters.count > 140 {
            SVProgressHUD.showInfoWithStatus("文本内容过长");
            return;
        }
        
        var urlString = "https://api.weibo.com/2/statuses/update.json";
        if (pictureSelectVC?.pictureList.count != 0){
            urlString = "https://upload.api.weibo.com/2/statuses/upload.json";
            let image = pictureSelectVC?.pictureList[0];
            let imageData = UIImagePNGRepresentation(image!);
            NetworkTools.uploadImage(urlString, status: statusText, imageData: imageData!);
        }else{
        //发送纯文本
            let parmas = ["access_token":sharedUserAccount?.access_token,"status":statusText];
            NetworkTools.requestJSON(.POST, URLString: urlString, parameters: parmas) { (JSON) in
                SVProgressHUD.showInfoWithStatus("发布成功");
                self.dismissViewControllerAnimated(true, completion: nil);
            }
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI();
        //注册键盘通知
        regNotification();
        // Do any additional setup after loading the view.
        for vc in childViewControllers as [UIViewController]{
            if vc is PictureSelectViewController{
                pictureSelectVC = vc as? PictureSelectViewController;
            }
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        if pictureSelectVC?.pictureList.count == 0{
            textView.becomeFirstResponder();
        }
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        
        textView.resignFirstResponder();
    }
    private func regNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.KeyBoardWillChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil);
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.KeyBoardWillChange(_:)), name: UIKeyboardWillHideNotification, object: nil);
    }
    private func setUpUI(){
        self.pictureViewHeightContraint.constant = 0;
        nameLabel.text = sharedUserAccount?.name;
        //添加站位文本
        textView.addSubview(placeHolderLabel);
        
    }
    func KeyBoardWillChange(notification:NSNotification){
        print(notification);
        //键盘出现的动画时间
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval;
        //键盘frame
        let rect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue();
        let height = self.view.frame.size.height - rect.origin.y;
        UIView.animateWithDuration(duration) { 
            self.toolBarBottomConstraints.constant = height;
        }
        
    }
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        textView.resignFirstResponder();
    }
    //MARK:textViewDelegate
    //文本框内容发生改变
    func textViewDidChange(textView: UITextView) {
        print(textView.text);
        sendBarItem.enabled = !textView.text.isEmpty;
        placeHolderLabel.hidden = !textView.text.isEmpty;
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        print("---------" + textView.text);
        print("replacementText:\(text)");
        if ((textView.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) + (text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)) > 10){
            return false;
        }
        return true;
    }
    
    
    @IBAction func selectPicture(sender: AnyObject) {
        //图片选择器高度占屏幕高度的1/3
        self.pictureViewHeightContraint.constant = UIScreen.mainScreen().bounds.height / 3;
        textView.resignFirstResponder();
    }
    
    

}
