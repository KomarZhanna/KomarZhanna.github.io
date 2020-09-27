//
//  LoginViewController.swift
//  Messenger
//
//  Created by Zhanna on 26.09.2020.
//

import UIKit

class RegistrationViewController: UIViewController, UINavigationControllerDelegate {

    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleToFill
        imageView.tintColor = UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00)
        imageView.layer.cornerRadius = 100
        imageView.layer.borderWidth = 5
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00).cgColor
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
    
    private let registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00), for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.textColor = UIColor(red: 0.43, green: 0.44, blue: 0.57, alpha: 1.00)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
                scrollView.isUserInteractionEnabled = true
        
        view.backgroundColor = UIColor(patternImage:UIImage(named: "bg2")!)
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        view.addSubview(emailField)
        view.addSubview(imageView)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(label)
        view.addSubview(registerButton)
        view.addSubview(nameField)
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfPic))
        
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfPic() {
        presentPhotoActionSheet()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.frame.width / 2
        
        imageView.frame = CGRect(x: (scrollView.frame.width-size)/2, y: 60, width: size, height: size)
        
        nameField.frame = CGRect(x:30, y: imageView.bottom + 50, width: scrollView.width - 60, height: 52)
        
        
        emailField.frame = CGRect(x:30, y: nameField.bottom + 30, width: scrollView.width - 60, height: 52)
        
        passwordField.frame = CGRect(x:30, y: emailField.bottom + 30, width: scrollView.width - 60, height: 52)
        
        
        let frameWidth: CGFloat  = 200.0
        
        registerButton.frame = CGRect(x: (view.bounds.width / 2) - (frameWidth / 2),y: passwordField.bottom + 50, width: frameWidth, height: 52)
        
        label.frame = CGRect(x: (view.bounds.width / 2) - (frameWidth / 2),y: registerButton.bottom + 100, width: frameWidth, height: 52)
        
        loginButton.frame = CGRect(x: (view.bounds.width / 2) - (frameWidth / 2),y: label.bottom + 5, width: frameWidth, height: 52)
        
    }
    
    @objc private func didTapLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func registerButtonTapped() {
        nameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text, let password = passwordField.text, let name = nameField.text, !email.isEmpty, !password.isEmpty, !name.isEmpty, password.count > 6 else {
            alertUserLoginError()
            return
        }
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops...", message: "Please enter all information to sign up ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: {[weak self] _ in
            self?.presentCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: {[weak self] _ in
            self?.presentLibrary()
        }))
        
        present(actionSheet, animated: true)
    }
    
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
