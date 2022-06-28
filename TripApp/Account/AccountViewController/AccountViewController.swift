//
//  SettingViewController.swift
//  TripApp
//
//  Created by Artem on 9.06.22.
//

import UIKit

class AccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var changePasswordLabel: UILabel!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var blur: UIVisualEffectView!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    // MARK: - Properies
    var viewModel: AccountViewModelProtocol! {
        didSet {
            viewModel.getUser()
        }
    }
    
    // MARK: - life cicle view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingViewModel()
        setupUI()
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newPasswordTextField.frame.origin.y = currentPasswordTextField.frame.origin.y
        confirmPasswordTextField.frame.origin.y = currentPasswordTextField.frame.origin.y
        clearPaswordTextFields()
    }
    
    
    // MARK: -
    @IBAction func saveChangesButtonPressed(_ sender: UIButton) {
        saveUserChanges()
        if !(currentPasswordTextField.text!.isEmpty) {
            saveNewPassword()
        }
        
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        viewModel.logout { [weak self] in
            self?.onMain {
                self?.tabBarController?.dismiss(animated: true)
                
            }
        }
        
    }
    
    
    private func setupUI() {
        configureTextField()
        viewModel.user.bind { [weak self] user in
            self?.blur.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.nameTextField.text = user.name
            self?.surnameTextField.text = user.surname
            self?.emailTextField.text = user.email
        }
        saveChangesButton.mainActionButton(with: "Сохранить", isEnable: true)
        changePasswordLabel.text = "Изменить пароль"
        logoutButton.grayButton(with: "Выйти из аккаунта", isEnable: true, sizeFont: 18)
    }
    
    
    private func configureTextField() {
        
        nameTextField.customConfigure(with: "Имя", returnKey: .next)
        nameTextField.autocapitalizationType = .sentences
        surnameTextField.customConfigure(with: "Фамилия", returnKey: .next)
        surnameTextField.autocapitalizationType = .sentences
        emailTextField.customConfigure(with: "Электронная почта", returnKey: .next)
        emailTextField.keyboardType = .emailAddress
        currentPasswordTextField.customConfigure(with: "Текущий пароль", returnKey: .next)
        currentPasswordTextField.delegate = self
        currentPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.customConfigure(with: "Новый пароль", returnKey: .next)
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.alpha = 0
        newPasswordTextField.frame.origin.y = currentPasswordTextField.frame.origin.y
        confirmPasswordTextField.customConfigure(with: "Повторите пароль", returnKey: .done)
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.alpha = 0
        confirmPasswordTextField.frame.origin.y = currentPasswordTextField.frame.origin.y
        
    }
    
    private func clearPaswordTextFields() {
        currentPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
    
    private func saveNewPassword() {
        guard let currentPassword = currentPasswordTextField.text,
              let newPassword = newPasswordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        
        viewModel.changePassword(current: currentPassword,
                                 newPassword: newPassword,
                                 confirmPassword: confirmPassword) { [weak self] stait in
            
            switch stait {
            case .success:
                
                let alert = Alert.shared.showAlert(title: "Успешно",
                                                   message: "Вы успешно сменили пароль",
                                                   buttonTitle: "Ок") {
                    self?.view.endEditing(true)
                    self?.clearPaswordTextFields()
                }
                self?.present(alert, animated: true)
            case .wrongCurrent:
                let alert = Alert.shared.showAlert(title: "Ошибка",
                                                   message: "Вы ввели текущий пароль не правильно",
                                                   buttonTitle: "Ок") {
                    self?.view.endEditing(true)
                    self?.clearPaswordTextFields()
                }
                self?.present(alert, animated: true)
            case .notEqualNew:
                let alert = Alert.shared.showAlert(title: "Ошибка",
                                                   message: "Новый пароль не совпадает с подтверждением или не соответствует требованиям",
                                                   buttonTitle: "Ок") {
                    self?.view.endEditing(true)
                    self?.clearPaswordTextFields()
                }
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func saveUserChanges() {
        
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
        guard let name = nameTextField.text,
              let surname = surnameTextField.text else { return }
        
        let email = emailTextField.text
        viewModel.saveChanges(name: name, surname: surname, email: email)
    }
    
}


// MARK: - UITextFieldDelegate
extension AccountViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
        case currentPasswordTextField:
            if newPasswordTextField.alpha == 0 {
                UIView.animate(withDuration: 0.3) {
                    self.newPasswordTextField.alpha = 1
                    self.confirmPasswordTextField.alpha = 1
                    self.newPasswordTextField.frame.origin.y += self.currentPasswordTextField.frame.height + 16
                    self.confirmPasswordTextField.frame.origin.y += self.newPasswordTextField.frame.height*2 + 16*2
                }
                print("current password begin editing")
            }
            
        default: break
        }
        
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        if newPasswordTextField.alpha == 1 {
            UIView.animate(withDuration: 0.3) {
                self.newPasswordTextField.alpha = 0
                self.confirmPasswordTextField.alpha = 0
                self.newPasswordTextField.frame.origin.y = self.currentPasswordTextField.frame.origin.y
                self.confirmPasswordTextField.frame.origin.y = self.currentPasswordTextField.frame.origin.y
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case currentPasswordTextField:
            newPasswordTextField.becomeFirstResponder()
        case newPasswordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextField:
            saveNewPassword()
            
            
        default: break
        }
        
        return true
    }
}
