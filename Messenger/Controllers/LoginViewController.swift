//
//  LoginViewController.swift
//  Messenger
//
//  Created by Zhanna on 26.09.2020.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "husky")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00), for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage:UIImage(named: "bg1")!)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        view.addSubview(emailField)
        view.addSubview(imageView)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        view.addSubview(label)
        view.addSubview(loginButton)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.frame.width / 2
        
        imageView.frame = CGRect(x: (scrollView.frame.width-size)/2, y: 60, width: size, height: size)
        
        emailField.frame = CGRect(x:30, y: imageView.bottom + 50, width: scrollView.width - 60, height: 52)
        
        passwordField.frame = CGRect(x:30, y: emailField.bottom + 30, width: scrollView.width - 60, height: 52)
        
        
        let frameWidth: CGFloat  = 200.0
        
        loginButton.frame = CGRect(x: (view.bounds.width / 2) - (frameWidth / 2),y: passwordField.bottom + 50, width: frameWidth, height: 52)
        
        label.frame = CGRect(x: (view.bounds.width / 2) - (frameWidth / 2),y: loginButton.bottom + 75, width: frameWidth, height: 52)
        
        registerButton.frame = CGRect(x: (view.bounds.width / 2) - (frameWidth / 2),y: label.bottom + 5, width: frameWidth, height: 52)
        
    }
    
    @objc private func didTapRegister() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func loginButtonTapped() {
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count > 6 else {
            alertUserLoginError()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let result = authResult, error == nil else {
                print("Error login user!")
                return
            }
            let user = result.user
            print("Login User \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops...", message: "Please enter all information to log in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}
