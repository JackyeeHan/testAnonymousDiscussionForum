//
//  ForumViewController.swift
//  testAnonymousDiscussionForum
//
//  Created by 黃柏瀚 on 2022/6/21.
//

import UIKit
import Firebase

class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var nickName = ""
    var key = ""
    var subJect = ""
    var dbReference:DatabaseReference!
    var commentArray:[[String:Any]] = []
    
    @IBOutlet weak var inputTextTF: UITextField!
    @IBOutlet weak var commentTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = subJect
        
        //取得資料位置??
        dbReference = Database.database().reference().child("comment").child(key)
        commentTabelView.dataSource = self
        commentTabelView.delegate = self
        
        dbReference.observe(.value) { snapshot in
                print("newData")
          
            self.commentArray.removeAll()
            
            
            //取得即時資料庫裡的資料
            for item in snapshot.children {
                if let itemSnapshot = item as? DataSnapshot{
                let comment = itemSnapshot.childSnapshot(forPath: "comment").value as? String ?? "不清楚"
                let nickname = itemSnapshot.childSnapshot(forPath: "user").value as? String ?? "不知道"
                let time:Double = (itemSnapshot.childSnapshot(forPath: "t").value as? Double ?? 0) / 1000
                
                //把時間轉為看得懂的格式
                let commentDate = Date(timeIntervalSince1970: time)
                let dateFomater = DateFormatter()
                dateFomater.dateFormat = "yyyy-MM-dd HH:mm"
                let dateString = dateFomater.string(from: commentDate)
                      
                    
                let commentContent = ["comment":comment,
                                      "user":nickname,
                                      "t":dateString,
                                      "theTime":time] as [String : Any]
                    
                self.commentArray.append(commentContent)
                    
                    print("==============")
                    print("\(comment)\n\(nickname)\n\(time)")
            }
                
            //藉由時間來排序讓新的資料在最上面
            self.commentArray.sort{
            $0["theTime"] as! Double > $1["theTime"] as! Double
            }
                
            self.commentTabelView.reloadData()
    }
    
}
}
    @IBAction func newComment(_ sender: Any) {
        let comment = inputTextTF.text ?? ""
        
        if comment.count < 1 {
            showMsg(msg: "訊息不能為空白", title: "錯誤")
            return
        }
        
        let commentRef = dbReference.childByAutoId()
        
        let commentContent = ["comment":comment,
                              "user":nickName,
                              "t":ServerValue.timestamp()] as [String: Any]
        commentRef.setValue(commentContent)
        inputTextTF.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentTableViewCell") as! CommentTableViewCell
        cell.comment.text = commentArray[indexPath.row]["comment"] as! String
        cell.nickName.text = commentArray[indexPath.row]["user"] as! String
        cell.date.text = commentArray[indexPath.row]["t"] as! String
        return cell
    }
    
}
