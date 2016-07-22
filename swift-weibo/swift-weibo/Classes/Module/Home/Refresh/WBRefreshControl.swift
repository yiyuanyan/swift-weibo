//
//  WBRefreshControl.swift
//  swift-weibo
//
//  Created by 何建新 on 16/7/21.
//  Copyright © 2016年 何建新. All rights reserved.
//

import UIKit

class WBRefreshControl: UIRefreshControl {
    var refreshView:WBRefreshView?;
    //初始化方法
    override init() {
        super.init();
        prepareView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func awakeFromNib() {
        prepareView();
    }
    
    private func prepareView(){
        //获取nib
        refreshView = NSBundle.mainBundle().loadNibNamed("RefreshView", owner: nil, options: nil).last as! WBRefreshView;
        //添加到视图
        addSubview(refreshView!);
//        //rView.setTranslatesAutoresizingMaskIntoConstraints(false);
//        var cons = [AnyObject]()
//        cons = cons + NSLayoutConstraint.constraintsWithVisualFormat("H:[rView(144)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["rView":rView]);
//        cons = cons + NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[rView(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["rView":rView]);
//        cons.append(NSLayoutConstraint(item: rView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0));
//        self.addConstraints(cons as AnyObject as! [NSLayoutConstraint]);
        
        //监听frame的变化
        self.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil);
        
    }
    //移除监听
    deinit{
        self.removeObserver(self, forKeyPath: "frame");
    }
    var showTipFlag = false;
    var isLoading = false;
    //监听方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print(frame);
        let offsetY = frame.origin.y;
        //判断是否正在刷新
        if refreshing && !isLoading{
            //正在刷新，播放刷新的动画
            isLoading = true;
            refreshView?.startLoading();
            return;
        }
        if offsetY < -65 && !showTipFlag{
            showTipFlag = true;
            //改变图片
            refreshView!.rotatetipIcon(showTipFlag);
            
        }else if(offsetY > -65 && showTipFlag){
            print("转回去")
            //重置标示
            showTipFlag = false;
            refreshView?.rotatetipIcon(showTipFlag);
        }
    }
    override func endRefreshing() {
        super.endRefreshing();
        //停止动画
        refreshView?.endLoading();
        //重置标识符
        //showTipFlag = false;
        isLoading = false;
    }
}
class WBRefreshView:UIView{
    
    @IBOutlet weak var tipIcon: UIImageView!
    
    @IBOutlet weak var loadingIcon: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    
    
    //刷新指针翻转
    private func rotatetipIcon(clockWise:Bool){
        var angel = CGFloat(M_PI)
        angel += clockWise ? -0.01 : 0.01;
        UIView.animateWithDuration(0.2) {
            self.tipIcon.transform = CGAffineTransformRotate(self.tipIcon.transform, angel);
        }
    }
    //正在刷新动画
    private func startLoading(){
        loadingView.hidden = false;
        let animation = CABasicAnimation(keyPath: "transform.rotation");
        animation.repeatCount = MAXFLOAT;
        animation.toValue = 2*M_PI
        animation.duration = 1;
        
        loadingIcon.layer.addAnimation(animation, forKey: nil);
    }
    
    private func endLoading(){
        //删除动画
        loadingIcon.layer.removeAllAnimations();
        //显示提示视图
        loadingView.hidden = true;
    }
    
    
}
