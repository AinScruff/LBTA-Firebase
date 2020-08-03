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
        let tl = UILabel()
        
        tl.font = UIFont(name: "Helvetica-Bold", size: 13)
        tl.textColor = .white
        tl.text = "Tap to Change"
        tl.textAlignment = .center
        
        return tl
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
    
    fileprivate let nameTextField: UITextField = {
        let nt = UITextField()
        
        nt.font = UIFont(name: "Helvetic", size: 17)
        nt.textColor = .white
        nt.attributedPlaceholder = NSAttributedString(string: "Name",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nt.borderStyle = .none
        nt.withImage(direction: .Left, image: #imageLiteral(resourceName: "user"), backgroundColor: .clear, colorSeparator: .clear, colorBorder: .clear)
        nt.clearButtonMode = .whileEditing
        nt.autocapitalizationType = .none
        
        return nt
    }()
    
    fileprivate let signUpButton: UIButton = {
        let sb = UIButton(type: .system)
        
        sb.backgroundColor = UIColor(hex: "#F6820DFF")
        sb.layer.cornerRadius = 5
        sb.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        sb.setTitleColor(.white, for: .normal)
        sb.setTitle("Sign Up", for: .normal)
        sb.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return sb
    }()
    
    fileprivate let logInButton: UIButton = {
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
        
        containerView.addSubview(signUpButton)
        containerView.verticalSpacing(topView: passwordTextField, bottomView: signUpButton, constant: 50)
        signUpButton.anchor(width: 250, height: 40)
        signUpButton.centerAnchor(centerX: containerView.centerXAnchor)
        
        containerView.addSubview(logInButton)
        containerView.verticalSpacing(topView: signUpButton, bottomView: logInButton, constant: 20)
        logInButton.anchor(width: 250, height: 30)
        logInButton.centerAnchor(centerX: containerView.centerXAnchor)
    }
}

// MARK: - Methods
extension SignUpViewController {
    
    fileprivate func keyboardHideOnTap() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        containerView.addGestureRecognizer(Tap)
    }

    fileprivate func validateTextFields() -> String? {
        
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
            return "Password should contain atleast one uppercase letter, atleast one number and it should be atleast 6 characters long"
        }
        
        return nil
    }
    
    // Present Error Alert View
    fileprivate func showError(_ message: String) {
        self.present(Utilities.showErrorView(title: "Register Error", message: message), animated: true, completion: nil)
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
                        
                        db.collection("users").addDocument(data: ["uid": result!.user.uid, "name": name, "imageUrl": urlString, "imageName": imageName]) { (error) in
                            
                            if error != nil {
                                self.showError("Error Saving User data")
                            }
                            
                        }
                    }
                    
                }
                
                if Auth.auth().currentUser != nil {
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        
                        if error == nil {
                            self.containerView.endEditing(true)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
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
        
        if validateTextFields() == nil{
            
            let name = nameTextField.text!
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            createUser(email, password, name)
        } else {
            self.showError(validateTextFields()!)
        }
    }
 
}
// MARK: - TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    
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
