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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var registerInfoLabel: UILabel!
    
    @IBOutlet weak var registrationTextLable: UILabel!
    
    @IBOutlet weak var conteinerTextFieldsView: UIView!
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
                  let password = passwordTextField.text,
                  passwordTextField.text!.count > 5 else { return }
            
            viewModel.registerUser(with: surname,
                                   name: name,
                                   phoneNumber: phoneNumber,
                                   password: password) { [weak self] success in
                guard success else {
                    //User is register already
                    let alertUserIsRegisterAlready = Alert.shared.showAlertUserIsRegisterAlready {
                        self?.phoneNumberTextField.text = ""
                    }
                    
                    self?.present(alertUserIsRegisterAlready, animated: true)
                    return
                }
                
                //User not found dataBase
                let smsController = ViewControllers.VerifySmsCodeViewController.rawValue
                guard let verifySmsVC = self?.storyboard?.instantiateViewController(withIdentifier: smsController) as? VerifySmsCodeViewController else { return }
                verifySmsVC.modalPresentationStyle = .fullScreen
                let user = User(name: name, surname: surname, email: nil, phoneNumber: phoneNumber, password: password)
                verifySmsVC.user = user
                self?.navigationController?.pushViewController(verifySmsVC, animated: true)
            }
            
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: - Custom function
    private func setupUI() {
        view.backgroundColor = mainBackgroundColor
        conteinerView.backgroundColor = .clear
        conteinerTextFieldsView.backgroundColor = mainBackgroundColor
        configureTextField()
        registerInfoLabel.text = "??????????????????????"
        registerInfoLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        registrationTextLable.text = "?????? ???????????????????????? ?????????????? ???????? ?????????? ????????????????, ??????, ?????????????? ?? ???????????? ?? ????????????????????????????"
        registrationTextLable.textColor = .lightText
        backButton.clearBackgroundButton(with: "??????????")
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        registButton.grayButton(with: "????????????????????????????????????", isEnable: false)
        mainScrollView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resignFirsResponderTap))
        mainScrollView.addGestureRecognizer(tapGesture)
    }
    
    private func configureTextField() {
        
        let textFieldArray = [surnameTextField, nameTextField, phoneNumberTextField, passwordTextField, confirmPasswordTextField]
        
        textFieldArray.forEach { textField in
            
            textField?.addTarget(self, action: #selector(dataOfUserNotEmpty), for: .editingChanged)
            textField?.delegate = self
            textField?.customConfigure(with: "11", returnKey: .next)
        }
        
        nameTextField.autocapitalizationType = .sentences
        nameTextField.placeholder = "??????"
        surnameTextField.placeholder = "??????????????"
        surnameTextField.autocapitalizationType = .sentences
        phoneNumberTextField.placeholder = "???????????????????? ??????????"
        phoneNumberTextField.keyboardType = .numberPad
        passwordTextField.placeholder = "????????????"
        confirmPasswordTextField.placeholder = "?????????????????????????? ????????????"
        confirmPasswordTextField.returnKeyType = .done
        
    }
    
    
    @objc private func resignFirsResponderTap() {
        mainScrollView.endEditing(true)
    }
    
    
    @objc private func kbWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let difference = conteinerTextFieldsView.frame.maxY - keyboardSize.origin.y
        mainScrollView.contentOffset = CGPoint(x: 0, y: difference)
    }
    
    @objc private func kbWillHide() {
        mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        
    }
    
    @objc private func dataOfUserNotEmpty(textField: UITextField) {
        
        let countPhoneNumber = isTested ? 4 : 9
        
        if !nameTextField.text!.isEmpty, !surnameTextField.text!.isEmpty,
           !phoneNumberTextField.text!.isEmpty, phoneNumberTextField.text?.count == countPhoneNumber,
           passwordTextField.text!.count > 5, passwordTextField.text == confirmPasswordTextField.text
            
        {
            registButton.mainActionButton(with: "????????????????????????????????????", isEnable: true)
            
        } else {
            registButton.grayButton(with: "????????????????????????????????????", isEnable: false)
        }
        
    }
    
}


extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTextField:
            surnameTextField.becomeFirstResponder()
        case surnameTextField:
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
    
    
}

extension RegisterViewController: UIScrollViewDelegate {
    
    
}
