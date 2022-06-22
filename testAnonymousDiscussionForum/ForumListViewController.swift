//
//  ForumListViewController.swift
//  testAnonymousDiscussionForum
//
//  Created by 黃柏瀚 on 2022/6/21.
//

import UIKit
import Firebase

class ForumListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var forumTableView: UITableView!
    
    var nickName = ""
    var keys:[String] = []
    var subject:[String] = []
    var selectedID:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forumTableView.delegate = self
        forumTableView.dataSource = self
        
        self.title = "討論區列表"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "goForumPage":
                let nextVC = segue.destination as? ForumViewController
                    nextVC?.nickName = self.nickName
                    nextVC?.key = keys[selectedID!]
                    nextVC?.subJect = subject[selectedID!]
            default:
                break
            }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showIndicator()
                        
        //取得資料庫裡的資料??
        let ref = Database.database().reference().child("forum")
            ref.observe( .value) { snapshot in
                self.removeIndicator()
                self.keys.removeAll()
                self.subject.removeAll()
                
        for item in snapshot.children{
            if let itemSnapshot = item as? DataSnapshot{
                let theSubject = itemSnapshot.childSnapshot(forPath: "subject").value as! String
                self.subject.append(theSubject)
                let key = itemSnapshot.key
                self.keys.append(key)
                        }
                    }
        self.forumTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = subject[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedID = indexPath.row
        self.performSegue(withIdentifier: "goForumPage", sender: self)
    }
    
    
}
