//
//  RegisterController.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 13.09.25.
//

import UIKit

class RegisterController: UIViewController {
    
    var registerCallback: ((String, String) -> Void)?

    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var fullnameTextField: UITextField!
    
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    @IBAction func createAccountButton(_ sender: Any) {
        let userFullname = fullnameTextField.text ?? ""
        let userPhone = phoneNumberTextField.text ?? ""
        let userEmail = emailTextField.text ?? ""
        let userPassword = passwordTextField.text ?? ""
        
        if userFullname.isEmpty {
            let alert = UIAlertController(title: "Xəta", message: "Adınızı yazın", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        if userPhone.isEmpty {
            let alert = UIAlertController(title: "Xəta", message: "Telefon nömrənizi yazın", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        if userEmail.isEmpty {
            let alert = UIAlertController(title: "Xəta", message: "Email yazın", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        if userPassword.isEmpty {
            let alert = UIAlertController(title: "Xəta", message: "Şifrə yazın", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        UserDefaults.standard.set(userFullname, forKey: "fullname")
        UserDefaults.standard.set(userPhone, forKey: "phoneNumber")
        UserDefaults.standard.set(userEmail, forKey: "email")
        UserDefaults.standard.set(userPassword, forKey: "password")
        
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.set(userEmail, forKey: "username")
        
        registerCallback?(userEmail, userPassword)
        
        let alert = UIAlertController(title: "Uğurla!", message: "Hesabınız yaradıldı", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
        
    }
                   
 }

