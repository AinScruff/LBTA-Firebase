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

    // MARK: - View Elements
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "firebase"))
        
        iv.contentMode = .scaleAspectFit
    
        return iv
    }()
    
    private let emailTextField: UITextField = {
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
    
    private let passwordTextField: UITextField = {
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
    
    private let logInButton: UIButton = {
        let lb = UIButton(type: .system)
        
        lb.backgroundColor = UIColor(hex: "#F6820DFF")
        lb.layer.cornerRadius = 5
        lb.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        lb.setTitleColor(.white, for: .normal)
        lb.setTitle("Log In", for: .normal)
        
        return lb
    }()
    
    private let signUpButton: UIButton = {
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
    
    private func setUpView() {
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
    
    private func keyboardHideOnTap() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc private func openSignUpView(sender: UIButton) {
        let vc = SignUpViewController()
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

/* TO DO
 - SIGN UP UI
 - LOG IN FIREBASE
 - HOME PAGE
 
 */

