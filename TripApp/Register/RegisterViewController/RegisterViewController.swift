//
//  RegisterViewController.swift
//  TripApp
//
//  Created by Artem on 16.06.22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: -  IBOutlets
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registButton: UIButton!
    
    // MARK: - properties
    private var viewModel: RegisterViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel()
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - IBAction
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if passwordTextField.text == confirmPasswordTextField.text {
            guard let surname = surnameTextField.text,
                  let name = nameTextField.text,
                  let phoneNumber = phoneNumberTextField.text,
                  let password = passwordTextField.text else { return }
                  
            viewModel.registerUser(with: surname,
                                   name: name,
                                   phoneNumber: phoneNumber,
                                   password: password)
            dismiss(animated: true)
        }
        
    }
    
    
    // MARK: - Custom function
    private func setupUI() {
        view.backgroundColor = mainBackgroundColor
        conteinerView.backgroundColor = mainBackgroundColor
        configureTextField()
        registButton.layer.cornerRadius = cornerRadiusButton
        mainScrollView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resignFirsResponderTap))
        mainScrollView.addGestureRecognizer(tapGesture)
    }
    
    private func configureTextField() {
        
        let textFieldArray = [surnameTextField, nameTextField, phoneNumberTextField, passwordTextField, confirmPasswordTextField]
        
        textFieldArray.forEach { textField in
            textField?.backgroundColor = .white
            textField?.textColor = .black
            textField?.tintColor = .red
            textField?.attributedPlaceholder = NSAttributedString(
                string: "Placeholder Text",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            textField?.font = .systemFont(ofSize: 20, weight: .light)
            textField?.delegate = self
            textField?.returnKeyType = .next
        }
        surnameTextField.placeholder = "Фамилия"
        nameTextField.placeholder = "Имя"
        phoneNumberTextField.placeholder = "Телефонный номер"
        passwordTextField.placeholder = "Пароль"
        confirmPasswordTextField.placeholder = "Подтверждение пароля"
        confirmPasswordTextField.returnKeyType = .done
        
    }
    
    
    @objc private func resignFirsResponderTap() {
            mainScrollView.endEditing(true)
    }
    
    @objc private func kbWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let difference = conteinerView.frame.maxY - keyboardSize.origin.y
        mainScrollView.contentOffset = CGPoint(x: 0, y: difference)
    }
    
    @objc private func kbWillHide() {
        mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        
    }
    
    
}


extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case surnameTextField:
            nameTextField.becomeFirstResponder()
        
        case nameTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextField:
            confirmPasswordTextField.resignFirstResponder()
        default: break
            
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    
}

extension RegisterViewController: UIScrollViewDelegate {
    
    
}
