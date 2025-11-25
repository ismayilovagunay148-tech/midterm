//
//  LoginController.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 13.09.25.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
        
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController else { return }
        navigationController?.show(controller, sender: nil)
        
        controller.registerCallback = { email, password in
            self.emailTextField.text = email
            self.passwordTextField.text = password
        }
    }
    @IBAction func LoginButton(_ sender: Any) {
        let userEmail = emailTextField.text ?? ""
        let userPassword = passwordTextField.text ?? ""
        
        if userEmail.isEmpty || userPassword.isEmpty {
            let alert = UIAlertController(title: "Xəta", message: "Email və şifrə yazın", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let savedEmail = UserDefaults.standard.string(forKey: "email")
        let savedPassword = UserDefaults.standard.string(forKey: "password")
        
        if userEmail == savedEmail && userPassword == savedPassword {
            
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.set(userEmail, forKey: "username")
            
            guard let controller = storyboard?.instantiateViewController(identifier: "HomeController") as? HomeController else { return }
            navigationController?.show(controller, sender: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Email və ya şifrə səhvdir", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
}
