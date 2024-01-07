//
//  LoginViewController.swift
//  NoBrokerAssignment
//
//  Created by Avinash Kumar on 07/01/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }

    func setupLogin() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductListingViewController") as! ProductListingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text else {
            self.showToast(message: "Email field can't be left blank", font: .systemFont(ofSize: 12))
            return
        }
        guard let password = passwordTextField.text else {
            self.showToast(message: "Password can't be empty", font: .systemFont(ofSize: 12))
            return
        }
        if loginViewModel.performValidationForEmail(email: email) && password == Password.password {
            setupLogin()
        } else {
            self.showToast(message: "Please Enter a valid Email and Password", font: .systemFont(ofSize: 12))
        }
    }
}

