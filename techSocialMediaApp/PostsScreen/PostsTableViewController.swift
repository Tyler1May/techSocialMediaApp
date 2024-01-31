//
//  PostsTableViewController.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/24/24.
//

import UIKit

class PostsTableViewController: UITableViewController, PostIdDelegate{
    
    let toCommentsIdentifier = "toComments"
    func commentButtonTapped(postId: Int) {
        performSegue(withIdentifier: toCommentsIdentifier, sender: postId)
    }
    var postCell: PostTableViewCell?
    func likeButtonTapped(postId: Int) {
        updateLikes(with: postId)
    }
    
    
    var posts: [Post] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        fetchPosts()
        tableView.reloadData()
        self.title = "Explore Posts"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == toCommentsIdentifier, let vc = segue.destination as? CommentsViewController, let postId = sender as? Int else {
            return
        }
        vc.postId = postId
    }
    
    func updateLikes(with postid: Int) {
        Task {
            do {
                try await API.updateLikes(with: postid)
                fetchPosts()
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPosts() {
        Task {
            do {
                self.posts = try await API.getPosts()
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
