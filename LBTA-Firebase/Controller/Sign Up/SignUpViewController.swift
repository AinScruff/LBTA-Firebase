//
//  SignUpViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/16/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - View Elements
    
    private let backButton: UIButton = {
        let bb = UIButton(type: .system)
        
        bb.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
        bb.setTitleColor(.white, for: .normal)
        bb.setTitle("Back", for: .normal)
        bb.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        return bb
    }()
    
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
    
    private let nameTextField: UITextField = {
        let nt = UITextField()
        
        nt.font = UIFont(name: "Helvetic", size: 17)
        nt.textColor = .white
        nt.attributedPlaceholder = NSAttributedString(string: "Name",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        nt.borderStyle = .none
        nt.withImage(direction: .Left, image: #imageLiteral(resourceName: "user"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        nt.clearButtonMode = .whileEditing
    
        return nt
    }()
    
    private let signUpButton: UIButton = {
        let sb = UIButton(type: .system)
        
        sb.backgroundColor = UIColor(hex: "#F6820DFF")
        sb.layer.cornerRadius = 5
        sb.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        sb.setTitleColor(.white, for: .normal)
        sb.setTitle("Sign Up", for: .normal)
        sb.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return sb
    }()
    
    private let logInButton: UIButton = {
        let lb = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an Account? ", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)!,NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        lb.setAttributedTitle(attributedTitle, for: .normal)
        lb.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        return lb
    }()
    
 
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        keyboardHideOnTap()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emailTextField.addBottomBorder(color: UIColor.white.cgColor)
        passwordTextField.addBottomBorder(color: UIColor.white.cgColor)
        nameTextField.addBottomBorder(color: UIColor.white.cgColor)
    }
    
}

// MARK: - Constraints
extension SignUpViewController {
    
    private func setUpView() {
        view.backgroundColor = .systemBlue
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, paddingTop: 10, paddingLeading: 20, width: 50, height: 50)
        
        view.addSubview(imageView)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50, width: 150, height: 150)
        imageView.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(nameTextField)
        view.verticalSpacing(topView: imageView, bottomView: nameTextField, constant: 50)
        nameTextField.anchor(width: 250, height: 40)
        nameTextField.centerAnchor(centerX: view.centerXAnchor)
        nameTextField.delegate = self
        
        view.addSubview(emailTextField)
        view.verticalSpacing(topView: nameTextField, bottomView: emailTextField, constant: 20)
        emailTextField.anchor(width: 250, height: 40)
        emailTextField.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(passwordTextField)
        view.verticalSpacing(topView: emailTextField, bottomView: passwordTextField, constant: 20)
        passwordTextField.anchor(width: 250, height: 40)
        passwordTextField.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(signUpButton)
        view.verticalSpacing(topView: passwordTextField, bottomView: signUpButton, constant: 50)
        signUpButton.anchor(width: 250, height: 40)
        signUpButton.centerAnchor(centerX: view.centerXAnchor)
        
        view.addSubview(logInButton)
        view.verticalSpacing(topView: signUpButton, bottomView: logInButton, constant: 20)
        logInButton.anchor(width: 250, height: 30)
        logInButton.centerAnchor(centerX: view.centerXAnchor)
    }
}

// MARK: - Methods
extension SignUpViewController {
    
    private func keyboardHideOnTap() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc private func dismissView(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func validateTextFields() -> String? {
    
        if nameTextField.text?.trimmingCharacters(in: .whitespaces) == "" {
            return "Name is required!"
        }
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Email is required!"
        }
        
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Password is required!"
        }
        
        if Utilities.isEmailValid(emailTextField.text!) == false {
            return "Email Format is Invalid!"
        }
        
        if Utilities.isPasswordValid(passwordTextField.text!) == false {
            return "Password should contain atleast one uppercase letter and atleast one number."
        }
        
        return nil
    }
    
     @objc private func signUp(sender: UIButton) {
        
        if validateTextFields() == nil{

        } else {
            let vc = AlertViewController()
                   
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.errorMessage = validateTextFields()!
            
            self.present(vc, animated: true, completion: nil)
        }
    }
       
}

// MARK: - TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == nameTextField {
            let allowedCharacter = CharacterSet.letters
            let allowedCharacter1 = CharacterSet.whitespaces
            let characterSet = CharacterSet(charactersIn: string)
               
            return allowedCharacter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
        }
        
        return true
    }
}
