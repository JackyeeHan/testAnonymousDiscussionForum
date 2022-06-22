//
//  FunctionPage.swift
//  testAnonymousDiscussionForum
//
//  Created by 黃柏瀚 on 2022/6/21.
//

import Foundation
import UIKit

//訊息的 alert
extension UIViewController{
    func showMsg(msg:String,title:String=""){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "我知道了", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //給進第二頁尚未顯示討論區資料時加個動畫
    func showIndicator(){
        //用一個 UIView 覆蓋整個 ViewController 畫面
        
        let bgView = UIView(frame: self.view.bounds)
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.5
        bgView.accessibilityIdentifier = "TheIndeView"
        
        let idicatorView = UIActivityIndicatorView(style: .large)
        idicatorView.color = UIColor.white
        idicatorView.center = self.view.center
        idicatorView.startAnimating()
        bgView.addSubview(idicatorView)
        self.view.addSubview(bgView)
    
    }
    
    func removeIndicator(){
        for theView in self.view.subviews{
            if theView.accessibilityIdentifier == "TheIndeView"{
                theView.removeFromSuperview()
            }
        }
        
        
    }  
    
}
extension String{
    func localize() -> String{
        return NSLocalizedString(self, comment: "")
    }
}
