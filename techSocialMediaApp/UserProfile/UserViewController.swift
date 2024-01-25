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
    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var bioDetailLabel: UILabel!
    @IBOutlet var techInterestLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfile()
        updateUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchProfile()
        updateUI()
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
    
    func updateUI() {
        self.title = "\(UserProfile.current?.userName ?? "UserName")"
        nameLabel.text = "\(UserProfile.current?.firstName ?? "")  \(UserProfile.current?.lastName ?? "")"
        emailLabel.text = "\(User.current?.email ?? "")"
        bioDetailLabel.text = "\(UserProfile.current?.bio ?? "")"
        techInterestLabel.text = "\(UserProfile.current?.techInterests ?? "")"
    }

    @IBAction func addPostTapped(_ sender: Any) {
        
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
