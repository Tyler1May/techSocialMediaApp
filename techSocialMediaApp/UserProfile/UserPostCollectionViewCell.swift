//
//  UserPostCollectionViewCell.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/19/24.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PostCollectionViewCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    
    func configure(with post: UserPosts) {
        titleLabel.text = post.title
        titleLabel.textColor = AppTheme.textColor
        bodyLabel.text = post.body
        bodyLabel.textColor = AppTheme.textColor
        likeLabel.text = "Likes: \(post.likes)"
        likeLabel.textColor = AppTheme.textColor
        commentLabel.text = "Comments: \(post.numComments)"
        commentLabel.textColor = AppTheme.textColor
        contentView.backgroundColor = AppTheme.secondaryColor
        contentView.layer.cornerRadius = 10
    }
}
