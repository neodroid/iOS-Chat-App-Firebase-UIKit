//
//  RegistrationController.swift
//  FireChat
//
//  Created by Kevin ahmad on 04/06/22.
//

import UIKit
import JGProgressHUD


class RegistrationController: UIViewController {

// MARK: - Properties
    private var viewModel = RegistrationViewModel()
    
    weak var delegate: AuthenticationDelegate?
    
private let imagePicker =  UIImagePickerController()
private var profileImage: UIImage?

private let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
    return button
}()

private let alreadyHaveAccountButton: UIButton = {
    let button = Utilities().attributtedButton("Already have an account? ", "Log in")
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
}()

private lazy var emailContainerView: UIView = {
    let view = Utilities().inputContainerView(withImage: UIImage(named: "ic_mail_outline_white_2x-1")!,textField: emailTextField)
    return view
}()

private lazy var passwordContainerView: UIView = {
    let view = Utilities().inputContainerView(withImage: UIImage(named: "ic_lock_outline_white_2x")!,textField: passwordTextField)
    return view
}()


private lazy var fullnameContainerView: UIView = {
    let view = Utilities().inputContainerView(withImage: UIImage(named: "ic_person_outline_white_2x")!,textField: fullnameTextField)
    return view
}()

private lazy var usernameContainerView: UIView = {
    let view = Utilities().inputContainerView(withImage: UIImage(named: "ic_person_outline_white_2x")!,textField: usernameTextField)
    return view
}()

private let emailTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Email")
    return tf
}()

private let passwordTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Password")
    tf.isSecureTextEntry = true
    return tf
}()

private let fullnameTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Full Name")
    return tf
}()

private let usernameTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Username")
    return tf
}()

private let registrationButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.setTitleColor(.twitterBlue, for: .normal)
    button.backgroundColor = .white
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
    button.isEnabled = false
    return button
}()

// MARK: - Lifecycle

override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNotificationObservers()
}

// MARK: - Selectors

@objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
}

@objc func handleSignup() {
    
    guard let profileImage = profileImage else {
        self.showError("Please select a profile image")
        return
    }
    
    guard let email = emailTextField.text else { return  }
    guard let password = passwordTextField.text else { return  }
    guard let fullname = fullnameTextField.text else { return  }
    guard let username = usernameTextField.text else { return  }
    
    print("lololololololol")
    self.showLoader(true,withText: "Signing up")
    let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
    

    AuthService.shared.createUser(credentials: credentials) { error in
        if let error = error {
            self.showLoader(false)
            self.showError(error.localizedDescription)
            
            return
        }
        self.showLoader(false)
        self.delegate?.authenticationComplete()
    }
}
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField {
            viewModel.email =  sender.text
        }else if sender == passwordTextField {
            viewModel.password =  sender.text
        }else if sender == fullnameTextField {
            viewModel.fullname =  sender.text
        }else {
            viewModel.username =  sender.text
        }
        checkFormStatus()
    }

@objc func handleAddProfilePhoto() {
    present(imagePicker, animated: true, completion: nil)
    
}

    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 88
        }
    }
    
    @objc func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
// MARK: - Helpers

    
func configureUI() {
    configureGradientLayer()
    self.navigationItem.setHidesBackButton(true, animated: true)

//    view.backgroundColor = .twitterBlue
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    view.addSubview(plusPhotoButton)
    plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
    plusPhotoButton.setDimensions(width: 128, height: 128)
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView ,registrationButton])
    stack.axis = .vertical
    stack.spacing = 20
    stack.distribution = .fillEqually
    
    view.addSubview(stack)
    stack.anchor(top:plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32,paddingLeft: 32, paddingRight: 32)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor ,right: view.rightAnchor,paddingLeft: 40, paddingRight: 40 )
}
    
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}



// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let profileImage = info[.editedImage] as? UIImage else {return}
    
    self.profileImage = profileImage
    
    plusPhotoButton.layer.cornerRadius = 128/2
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.imageView?.contentMode = .scaleAspectFill
    plusPhotoButton.imageView?.clipsToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 3
    
    self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
    
    
    
    dismiss(animated: true, completion: nil)
}
    
    
}

extension RegistrationController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            registrationButton.isEnabled = true
            registrationButton.backgroundColor = .systemPink
        } else {
            registrationButton.isEnabled = false
            registrationButton.backgroundColor = .white
        }
        
        
    }
}


