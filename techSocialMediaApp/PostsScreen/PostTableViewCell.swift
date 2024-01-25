//
//  PostTableViewCell.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/24/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    static let reuseIdentifier = "postCell"
    
    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var authorUsernameButton: UIButton!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var postDateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with post: Post) {
        postTitleLabel.text = post.title
        authorUsernameButton.setTitle(post.authorUserName, for: .normal)
        bodyLabel.text = post.body
        likeButton.setTitle("\(post.likes)", for: .normal)
        commentButton.setTitle("\(post.numComments)", for: .normal)
        postDateLabel.text = post.createdDate
    }

}
