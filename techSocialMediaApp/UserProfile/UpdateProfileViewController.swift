//
//  updateProfileViewController.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/22/24.
//

import UIKit

class UpdateProfileViewController: UIViewController {
    
    weak var updateProfileDelegate: UpdateProfileDelegate?
    

    @IBOutlet var usernameTitleLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var bioTitleLabel: UILabel!
    @IBOutlet var bioTextField: UITextField!
    @IBOutlet var techTitleLabel: UILabel!
    @IBOutlet var techInterestTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppTheme.setPrimaryBackgroundColor(for: self.view)
        
        usernameTextField.text = UserProfile.current?.userName
        usernameTitleLabel.textColor = AppTheme.textColor
        usernameTextField.textColor = AppTheme.textColor
        usernameTextField.backgroundColor = AppTheme.secondaryColor
        bioTextField.text = UserProfile.current?.bio
        bioTitleLabel.textColor = AppTheme.textColor
        bioTextField.textColor = AppTheme.textColor
        bioTextField.backgroundColor = AppTheme.secondaryColor
        techInterestTextField.text = UserProfile.current?.techInterests
        techTitleLabel.textColor = AppTheme.textColor
        techInterestTextField.backgroundColor = AppTheme.secondaryColor
        techInterestTextField.textColor = AppTheme.textColor
        saveButton.tintColor = AppTheme.secondaryColor
        
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
