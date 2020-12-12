//
//  LogInViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/5/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate let validation: LogInValidationService
    fileprivate let userService: UserService
    fileprivate let defaults = UserDefaults.standard
    fileprivate let auth = Constants.API.AUTH_REF
    
    // MARK: - Initialization
    
    init(validation: LogInValidationService, userService: UserService) {
        self.validation = validation
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Elements
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "firebase"))
        
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont(name: "Helvetica", size: 17)
        textField.textColor = .white
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.borderStyle = .none
        textField.withImage(direction: .Left, image: #imageLiteral(resourceName: "email"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    fileprivate let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont(name: "Helvetic", size: 17)
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        textField.borderStyle = .none
        textField.withImage(direction: .Left, image: #imageLiteral(resourceName: "lock"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    fileprivate let logInButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor(hex: "#F6820DFF")
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't Have an Account? ", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)!,NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(openSignUpView), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        keyboardHideOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emailTextField.addBottomBorder(color: UIColor.white.cgColor)
        passwordTextField.addBottomBorder(color: UIColor.white.cgColor)
    }
}

// MARK: - Contraints
extension LogInViewController {
    
    fileprivate func setUpView() {
        view.backgroundColor = .systemBlue
        
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50, width: 150, height: 150)
        imageView.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(emailTextField)
        view.verticalSpacing(topView: imageView, bottomView: emailTextField, constant: 50)
        emailTextField.anchor(width: 250, height: 40)
        emailTextField.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(passwordTextField)
        view.verticalSpacing(topView: emailTextField, bottomView: passwordTextField, constant: 20)
        passwordTextField.anchor(width: 250, height: 40)
        passwordTextField.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(logInButton)
        view.verticalSpacing(topView: passwordTextField, bottomView: logInButton, constant: 50)
        logInButton.anchor(width: 250, height: 40)
        logInButton.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(signUpButton)
        view.verticalSpacing(topView: logInButton, bottomView: signUpButton, constant: 20)
        signUpButton.anchor(width: 250, height: 30)
        signUpButton.centerAnchor(centerX: view.centerXAnchor)
    }
}

// MARK: - Methods
extension LogInViewController {
    
    fileprivate func keyboardHideOnTap() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    
    fileprivate func validateTextField() -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Email is required!"
        }
        
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Password is required!"
        }
        
        return nil
    }
    
    fileprivate func showError(message: String, sender: UIButton) {
        self.present(Utilities.showErrorView(title: "Log In Error", message: message), animated: true, completion: nil)
        UIView.transition(with: sender, duration: 0.1, options: .curveEaseInOut, animations: {
            sender.backgroundColor = UIColor(hex: "#F6820DFF")
            sender.isEnabled = true
        })
    }

}

// MARK: - Button Methods
extension LogInViewController {
    
    @objc fileprivate func DismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc fileprivate func openSignUpView(sender: UIButton) {
        let vc = SignUpViewController()
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc fileprivate func logIn(sender: UIButton) {
        
        // Deselect selected textField
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        UIView.transition(with: sender, duration: 0.1, options: .curveEaseInOut, animations: {
            sender.backgroundColor = .systemGray
            sender.isEnabled = false
        })
        
        do {
            let email = try validation.isEmailValid(emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            let password = try validation.isPasswordValid( passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                
            auth.signIn(withEmail: email, password: password) { (result, error) in
            
                if error != nil {
                    self.showError(message: "Invalid Email or Password!", sender: sender)
                } else {
                    self.userService.fetchUserData(userID: self.auth.currentUser?.uid) { [weak self] user in
                        
                        UserProfileCache.save(user)
                       
                        let vc = TabBarViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: false, completion: nil)
                        
                        self?.emailTextField.text?.removeAll()
                        self?.passwordTextField.text?.removeAll()
                        
                        UIView.transition(with: sender, duration: 0.1, options: .curveEaseInOut, animations: {
                            sender.backgroundColor = UIColor(hex: "#F6820DFF")
                            sender.isEnabled = true
                        })
                    }
                }
            }
            
        } catch {
            showError(message: error.localizedDescription, sender: sender)
        }
    }
}
