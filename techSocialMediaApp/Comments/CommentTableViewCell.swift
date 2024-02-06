//
//  CommentTableViewCell.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/29/24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let reuseIdentifier = "commentCell"
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with comment: Comment) {
        usernameLabel.text = comment.userName
        usernameLabel.textColor = AppTheme.textColor
        dateLabel.text = comment.createdDate
        dateLabel.textColor = AppTheme.textColor
        bodyLabel.text = comment.body
        bodyLabel.textColor = AppTheme.textColor
        contentView.backgroundColor = AppTheme.secondaryColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
}
