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
        bodyLabel.text = post.body
        likeLabel.text = "Likes: \(post.likes)"
        commentLabel.text = "Comments: \(post.numComments)"
    }
}
