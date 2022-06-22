//
//  CommentTableViewCell.swift
//  testAnonymousDiscussionForum
//
//  Created by 黃柏瀚 on 2022/6/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
