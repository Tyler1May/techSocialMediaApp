//
//  ViewController.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/20/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var appTitleLabel: UILabel!
    
    var authenticationController = AuthenticationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = AppTheme.primaryColor
        emailTextField.backgroundColor = AppTheme.secondaryColor
        passwordTextField.backgroundColor = AppTheme.secondaryColor
        appTitleLabel.textColor = AppTheme.textColor
        signInButton.titleLabel?.tintColor = AppTheme.textColor
        
        passwordTextField.isSecureTextEntry = true
        #if DEBUG
//        Uncomment the three lines below and enter your credentials to
//        automatically sign in everytime you launch the app.
        
        emailTextField.text = "TYLER.MAY1143@STU.MTEC.EDU"
        passwordTextField.text = "2ecefba6-43e3-4658-a7b9-d0b02a719f38"
        signInButtonTapped([])
        #endif
    }

    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty else {return}
        
        Task {
            do {
                // Make the API Call
                let success = try await authenticationController.signIn(email: email, password: password)
                if(success) {
                    // Change the navigation stack to make the next view controller be the root view controller
                    // We do this because we dont want a back button to the sign in page.
                    let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "userSignedIn")
                    let viewControllers = [viewController]
                    self.navigationController?.setViewControllers(viewControllers, animated: true)
//                    print(User.current?.secret)
//                    print(User.current?.userUUID)
                }
            } catch {
                print(error)
                errorLabel.text = "Invalid Username or Password"
            }
        }
    }
    
}

