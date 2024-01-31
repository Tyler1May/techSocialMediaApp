//
//  UserViewController.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/19/24.
//

import UIKit

protocol UpdateProfileDelegate: AnyObject {
    func updateProfile()
}

class UserViewController: UIViewController, UpdateProfileDelegate {
    func updateProfile() {
        updateUI()
    }
    
    var userPosts: [UserPosts] = []
    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var bioDetailLabel: UILabel!
    @IBOutlet var techInterestLabel: UILabel!
    
    @IBOutlet var postCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfile()
        updateUI()
        postCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)

        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        fetchUserPosts()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchProfile()
        updateUI()
        fetchUserPosts()
    }
    
    
    func fetchProfile() {
        Task {
            do {
                let newUser = try await API.fetchUserProfile()
                updateUI()
            } catch {
                print(error)
            }
            
        }
    }
    
    func fetchUserPosts() {
        Task {
            do {
                self.userPosts = try await API.getUserPosts()
                self.postCollectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateUI() {
        self.title = "\(UserProfile.current?.userName ?? "UserName")"
        nameLabel.text = "\(UserProfile.current?.firstName ?? "")  \(UserProfile.current?.lastName ?? "")"
        emailLabel.text = "\(User.current?.email ?? "")"
        bioDetailLabel.text = "\(UserProfile.current?.bio ?? "")"
        techInterestLabel.text = "\(UserProfile.current?.techInterests ?? "")"
    }
    
    func deletePost(_ post: UserPosts) {
        Task {
            do {
                try await API.deletePosts(post)
                DispatchQueue.main.async {
                    self.userPosts.removeAll(where: { $0.postid == post.postid })
                    self.postCollectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendPost(_ post: CreatePost) {
        Task {
            do {
                try await API.createPost(post)
                DispatchQueue.main.async {
                    self.fetchUserPosts()
                    self.postCollectionView.reloadData()
                }
            } catch {
                
            }
        }
    }

    @IBAction func addPostTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Create Post", message: nil, preferredStyle: .alert)
        ac.addTextField { text in
            text.placeholder = "Post title"
        }
        ac.addTextField { text in
            text.placeholder = "Post body"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let postAction = UIAlertAction(title: "Post", style: .default) { [weak self, weak ac] _ in
            let secret = User.current?.secret
            if let secret = secret {
                let sendPost = SendPost(title: ac?.textFields?[0].text ?? "", body: ac?.textFields?[1].text ?? "")
                let post = CreatePost(userSecret: secret.uuidString, post: sendPost)
                self?.sendPost(post)
            }
        }
        
        ac.addAction(cancelAction)
        ac.addAction(postAction)
        present(ac, animated: true)
        
    }
    
    @IBAction func editTapped(_ sender: Any) {
        
    }
    
    @IBAction func unwindToUser(_ sender: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editProfile",
              let vc = segue.destination as? UpdateProfileViewController else { return }
        vc.updateProfileDelegate = self
    }
    
    
    
}

extension UserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        
        let post = userPosts[indexPath.item]
        cell.configure(with: post)
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let i = indexPaths.first else { return nil }
        let post = userPosts[i.item]
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "Delete") { (action) in
                self.deletePost(post)
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        return config
    }
    
}
