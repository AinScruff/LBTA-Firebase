//
//  SignUpViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/16/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    let validation = SignUpValidationService.shared
    
    var isViewCollapsed: Bool = false
    var heightConstraint = NSLayoutConstraint()

    // MARK: - View Elements
    
    fileprivate lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 20)
    fileprivate lazy var backgroundColor: UIColor = .systemBlue
    
    fileprivate lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        
        view.backgroundColor = self.backgroundColor
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        
        return view
    }()
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = self.backgroundColor
        view.frame.size = contentViewSize
        
        return view
    }()
    
    fileprivate let backButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "defaultPP"))
        
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    fileprivate let uploadImageButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let tapToChangeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Helvetica-Bold", size: 13)
        label.textColor = .white
        label.text = "Tap to Change"
        label.textAlignment = .center
        
        return label
    }()
    
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont(name: "Helvetica", size: 17)
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.borderStyle = .none
        textField.withImage(direction: .Left, image: #imageLiteral(resourceName: "email"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.textColor = .white
        
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
    
    fileprivate let nameTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = UIFont(name: "Helvetic", size: 17)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.borderStyle = .none
        textField.withImage(direction: .Left, image: #imageLiteral(resourceName: "user"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none

        
        return textField
    }()
    
    fileprivate let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = UIColor(hex: "#F6820DFF")
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let logInButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an Account? ", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 15)!,NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let passwordValidationView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
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
        imageView.setRounded(borderColor: UIColor.white.cgColor)
    }
    
}

// MARK: - Constraints
extension SignUpViewController {
    
    fileprivate func setUpView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: containerView.leadingAnchor, paddingTop: 10, paddingLeading: 20, width: 50, height: 50)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, paddingTop: 50, width: 100, height: 100)
        imageView.centerAnchor(centerX: containerView.centerXAnchor)
        
        containerView.addSubview(uploadImageButton)
        uploadImageButton.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, paddingTop: 50, width: 100, height: 100)
        uploadImageButton.centerAnchor(centerX: containerView.centerXAnchor)
        
        containerView.addSubview(tapToChangeLabel)
        containerView.verticalSpacing(topView: imageView, bottomView: tapToChangeLabel, constant: 10)
        tapToChangeLabel.anchor(width: 100, height: 20)
        tapToChangeLabel.centerAnchor(centerX: containerView.centerXAnchor)
        
        containerView.addSubview(nameTextField)
        containerView.verticalSpacing(topView: tapToChangeLabel, bottomView: nameTextField, constant: 15)
        nameTextField.anchor(width: 250, height: 40)
        nameTextField.centerAnchor(centerX: containerView.centerXAnchor)
        nameTextField.delegate = self
        
        containerView.addSubview(emailTextField)
        containerView.verticalSpacing(topView: nameTextField, bottomView: emailTextField, constant: 20)
        emailTextField.anchor(width: 250, height: 40)
        emailTextField.centerAnchor(centerX: containerView.centerXAnchor)
        
        containerView.addSubview(passwordTextField)
        containerView.verticalSpacing(topView: emailTextField, bottomView: passwordTextField, constant: 20)
        passwordTextField.anchor(width: 250, height: 40)
        passwordTextField.centerAnchor(centerX: containerView.centerXAnchor)
        
        containerView.addSubview(passwordValidationView)
        passwordValidationView.anchor(top: passwordTextField.bottomAnchor, paddingTop: 5, width: 250)
        heightConstraint = passwordValidationView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        passwordValidationView.centerAnchor(centerX: containerView.centerXAnchor)
        
        containerView.addSubview(signUpButton)
        containerView.verticalSpacing(topView: passwordValidationView, bottomView: signUpButton, constant: 25)
        signUpButton.anchor(width: 250, height: 40)
        signUpButton.centerAnchor(centerX: containerView.centerXAnchor)

        containerView.addSubview(logInButton)
        containerView.verticalSpacing(topView: signUpButton, bottomView: logInButton, constant: 20)
        logInButton.anchor(width: 250, height: 30)
        logInButton.centerAnchor(centerX: containerView.centerXAnchor)
        
        textFieldDelegate()
    }
    
    func textFieldDelegate() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

// MARK: - Methods
extension SignUpViewController {
    
    fileprivate func keyboardHideOnTap() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        containerView.addGestureRecognizer(Tap)
    }
    
    // Present Error Alert View
    fileprivate func showError(_ message: String) {
        self.present(Utilities.showErrorView(title: "Register Error", message: message), animated: true, completion: nil)
        UIView.transition(with: signUpButton, duration: 0.1, options: .curveEaseInOut, animations: {
            self.signUpButton.backgroundColor = UIColor(hex: "#F6820DFF")
            self.signUpButton.isEnabled = true
        })
    }
    
    // Create User
    fileprivate func createUser(_ email: String, _ password: String, _ name: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            if err != nil {
                self.showError("Error Adding to DB")
            } else {
                
                guard let image = self.imageView.image, let data = image.jpegData(compressionQuality: 1.0) else {
                    self.showError("Please upload Profile Picture")
                    return
                }
                
                let db = Firestore.firestore()
                
                let imageName = UUID().uuidString
                let imageReference = Storage.storage().reference().child("userProfileImagesFolder").child(imageName)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"

                imageReference.putData(data, metadata: metadata) { (metadata, err) in
                    
                    if let err = err {
                        self.showError(err.localizedDescription)
                        return
                    }
                    
                    imageReference.downloadURL { (url, err) in
                        guard let url = url else {
                            self.showError("Something Went Wrong")
                            return
                        }
                        
                        let urlString = url.absoluteString
                        
                        db.collection("users").document(result!.user.uid).setData([
                            "name": name,
                            "imageUrl": urlString,
                            "imageName": imageName,
                            "uid": result!.user.uid
                        ]) { (err) in
                            if err != nil {
                                self.showError("Error Saving User data")
                            }
                        }
                    }
                    
                }
                
                if Auth.auth().currentUser != nil {
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        
                        if error == nil {
                            self.containerView.endEditing(true)
                            
                            let vc = TabBarViewController()
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func showPasswordValidationView() {
        
        let constant: CGFloat = isViewCollapsed ? 150 : 0
        
        heightConstraint.constant = constant
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.containerView.superview?.layoutIfNeeded()
        }, completion: nil)
        
    }
}

// MARK: - Button Methods
extension SignUpViewController {
    
    @objc fileprivate func DismissKeyboard(){
        containerView.endEditing(true)
    }
    
    @objc fileprivate func dismissView(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func uploadImage(sender: UIButton) {
        showPickerController()
    }

    @objc fileprivate func signUp(sender: UIButton) {
        
        do {
            
            let name = try validation.isNameValid(nameTextField.text!)
            let email = try validation.isEmailValid(emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            let password = try validation.isPasswordValid(passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            
            createUser(email, password, name)
        } catch {
            showError(error.localizedDescription)
        }
    }
}
// MARK: - TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            isViewCollapsed = false
            showPasswordValidationView()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            isViewCollapsed = true
            showPasswordValidationView()
        
        }
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == nameTextField {
            
            // Name TextField must be letters only
            let allowedCharacter = CharacterSet.letters
            let allowedCharacter1 = CharacterSet.whitespaces
            let characterSet = CharacterSet(charactersIn: string)
            
            return allowedCharacter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
        }
        
        return true
    }
}

// MARK: - ImagePicker Delegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    fileprivate func showPickerController() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = selectedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
