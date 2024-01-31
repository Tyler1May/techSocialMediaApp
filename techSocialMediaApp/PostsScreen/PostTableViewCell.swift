//
//  PostTableViewCell.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/24/24.
//

import UIKit
protocol PostIdDelegate: AnyObject {
    func commentButtonTapped(postId: Int)
    func likeButtonTapped(postId: Int)
}

class PostTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "postCell"
    weak var delegate: PostIdDelegate?
    var selectedPostId = 0
    var like: Bool = false
    
    @IBOutlet var postTitleLabel: UILabel!
    @IBOutlet var authorUsernameLabel: UILabel!
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
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        delegate?.commentButtonTapped(postId: selectedPostId)
        
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        delegate?.likeButtonTapped(postId: selectedPostId)
    }
    
    
    func configure(with post: Post) {
        postTitleLabel.text = post.title
        authorUsernameLabel.text = post.authorUserName
        bodyLabel.text = post.body
        likeButton.setTitle("\(post.likes)", for: .normal)
        commentButton.setTitle("\(post.numComments)", for: .normal)
        postDateLabel.text = post.createdDate
        self.selectedPostId = post.postid
        self.like = post.userLiked
        if like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

}
