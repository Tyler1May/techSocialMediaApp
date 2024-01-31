//
//  updateProfileViewController.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/22/24.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    
    weak var updateProfileDelegate: UpdateProfileDelegate?
    

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var bioTextField: UITextField!
    @IBOutlet var techInterestTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = UserProfile.current?.userName
        bioTextField.text = UserProfile.current?.bio
        techInterestTextField.text = UserProfile.current?.techInterests
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let userText = usernameTextField.text,
              let bioText = bioTextField.text,
              let techText = techInterestTextField.text else { return }
        
        let newProfile = Profile(userName: userText, bio: bioText, techInterest: techText)
        
        Task {
            do {
                try await API.editUserProfile(newProfile)
                UserProfile.current?.userName = userText
                UserProfile.current?.bio = bioText
                UserProfile.current?.techInterests = techText
                performSegue(withIdentifier: "save", sender: self)
                updateProfileDelegate?.updateProfile()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
}
