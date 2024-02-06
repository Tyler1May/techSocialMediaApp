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
        postTitleLabel.textColor = AppTheme.textColor
        authorUsernameLabel.text = post.authorUserName
        authorUsernameLabel.textColor = AppTheme.textColor
        bodyLabel.text = post.body
        bodyLabel.textColor = AppTheme.textColor
        likeButton.setTitle("\(post.likes)", for: .normal)
        commentButton.setTitle("\(post.numComments)", for: .normal)
        commentButton.tintColor = AppTheme.textColor
        postDateLabel.text = post.createdDate
        postDateLabel.textColor = AppTheme.textColor
        self.selectedPostId = post.postid
        self.like = post.userLiked
        if like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = UIColor.systemPink
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = AppTheme.textColor
        }
        contentView.backgroundColor = AppTheme.secondaryColor
        contentView.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}
