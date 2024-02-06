//
//  CommentsViewController.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/29/24.
//

import UIKit

class CommentsViewController: UIViewController {
    
    
    var comments: [Comment] = []
    private var post: Post?
    var postId: Int = 0
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var addCommentButton: UIButton!
    @IBOutlet var commentTitleLabel: UILabel!
    
    @IBOutlet var commentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppTheme.setPrimaryBackgroundColor(for: self.view)
        commentTextField.backgroundColor = AppTheme.secondaryColor
        commentTextField.textColor = AppTheme.textColor
        commentTitleLabel.textColor = AppTheme.textColor
        addCommentButton.backgroundColor = AppTheme.buttonColor
        addCommentButton.configuration?.baseForegroundColor = AppTheme.textColor
        
        commentTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        
        commentTableView.dataSource = self
        commentTableView.delegate = self
        fetchComments()
        commentTableView.reloadData()
        

    }
    
    func createComment() {
        Task {
            do {
                let newComment = try await API.createComment(with: self.commentTextField.text ?? " ", with: postId)
                self.comments.append(newComment)
                commentTextField.text = ""
                commentTextField.placeholder = "Comment..."
                commentTableView.reloadData()
            }
        }
    }
    
    @IBAction func addCommentTapped(_ sender: Any) {
        createComment()
        commentTableView.reloadData()
    }
    

    func fetchComments() {
        Task {
            do {
                self.comments = try await API.getComments(for: postId)
                commentTableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier) as! CommentTableViewCell
        
        let comment = comments[indexPath.row]
        cell.configure(with: comment)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
