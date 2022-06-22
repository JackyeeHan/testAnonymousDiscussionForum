//
//  ViewController.swift
//  testAnonymousDiscussionForum
//
//  Created by 黃柏瀚 on 2022/6/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var nickNameTF: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().signInAnonymously(completion: nil)
                Auth.auth().addStateDidChangeListener { auth, user in
                    if let user = user{
                        print("SingIned")
                        print(user.uid)
                        
                        self.statusLabel.text = "己登入"
                    }else{
                        self.statusLabel.text = "己登出"
                        print("SignOut")
                    }
                }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           switch segue.identifier {
           case "goListPage":
               let nextVC = segue.destination as? ForumListViewController
               nextVC?.nickName = nickNameTF.text ?? ""
           default:
               break
           }
       }
 
    @IBAction func goForumList(_ sender: Any) {        
        let nickName = nickNameTF.text ?? ""
            //暱稱不能空白提示
            if nickName.count < 1 {
                self.showMsg(msg: "暱稱不能為空白".localize(),title: "提示".localize())
                return
    }
        //檢查是否已經登入
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "goListPage", sender: self)
            }else{
            self.showMsg(msg: "尚未登入")
        }
}

}
