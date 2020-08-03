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
    

    // MARK: - View Elements
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "firebase"))
        
        iv.contentMode = .scaleAspectFit
    
        return iv
    }()
    
    fileprivate let emailTextField: UITextField = {
        let et = UITextField()
        
        et.font = UIFont(name: "Helvetica", size: 17)
        et.textColor = .white
        //et.delegate = self
        et.keyboardType = .emailAddress
        et.attributedPlaceholder = NSAttributedString(string: "Email",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        et.borderStyle = .none
        et.withImage(direction: .Left, image: #imageLiteral(resourceName: "email"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        et.clearButtonMode = .whileEditing
        et.autocapitalizationType = .none
        
        return et
    }()
    
    fileprivate let passwordTextField: UITextField = {
        let pt = UITextField()
        
        pt.font = UIFont(name: "Helvetic", size: 17)
        pt.textColor = .white
        //et.delegate = self
        pt.isSecureTextEntry = true
        pt.attributedPlaceholder = NSAttributedString(string: "Password",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        pt.borderStyle = .none
        pt.withImage(direction: .Left, image: #imageLiteral(resourceName: "lock"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        pt.clearButtonMode = .whileEditing
        
        return pt
    }()
    
    fileprivate let logInButton: UIButton = {
        let lb = UIButton(type: .system)
        
        lb.backgroundColor = UIColor(hex: "#F6820DFF")
        lb.layer.cornerRadius = 5
        lb.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        lb.setTitleColor(.white, for: .normal)
        lb.setTitle("Log In", for: .normal)
        lb.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        return lb
    }()
    
    fileprivate let signUpButton: UIButton = {
        let sb = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't Have an Account? ", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)!,NSAttributedString.Key.foregroundColor: UIColor.white]))
 
        sb.setAttributedTitle(attributedTitle, for: .normal)
        sb.addTarget(self, action: #selector(openSignUpView), for: .touchUpInside)
        
        return sb
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        keyboardHideOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
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
    
    fileprivate func showError(message: String) {
        self.present(Utilities.showErrorView(title: "Log In Error", message: message), animated: true, completion: nil)
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
        
        UIView.transition(with: sender, duration: 0.1, options: .curveEaseInOut, animations: {
            sender.backgroundColor = .systemGray
            sender.isEnabled = false
        })
        
        if validateTextField() == nil {
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                UIView.transition(with: sender, duration: 0.1, options: .curveEaseInOut, animations: {
                                       sender.backgroundColor = UIColor(hex: "#F6820DFF")
                                       sender.isEnabled = true
                })
                
                if error != nil {
                    // Couldn't Sign In
                    self.showError(message: "Invalid Email or Password!")
                } else {
                    // Sign In Successful
                    let vc = ChatViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false, completion: nil)
                }
            }
        } else {
            self.showError(message: validateTextField()!)
            UIView.transition(with: sender, duration: 0.1, options: .curveEaseInOut, animations: {
                                   sender.backgroundColor = UIColor(hex: "#F6820DFF")
                                   sender.isEnabled = true
            })
        }
    
    }
}
