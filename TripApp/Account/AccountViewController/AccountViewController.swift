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
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    // MARK: - Properies
    var viewModel: AccountViewModelProtocol! {
        didSet {
            nameTextField.text = viewModel.user?.name
            surnameTextField.text = viewModel.user?.surname
            emailTextField.text = viewModel.user?.email
            
        }
    }
    // MARK: - life cicle view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingViewModel()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newPasswordTextField.frame.origin.y = currentPasswordTextField.frame.origin.y
        confirmPasswordTextField.frame.origin.y = currentPasswordTextField.frame.origin.y
        clearPaswordTextFields()
    }
    

    // MARK: -
    @IBAction func saveChangesButtonPressed(_ sender: UIButton) {
        saveUserChanges()
        saveNewPassword()
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        viewModel.logout()
        dismiss(animated: true)
    }
    
    
    private func setupUI() {
        configureTextField()
        saveChangesButton.orangeButton(with: "Сохранить", isEnable: true)
        
        logoutButton.backgroundColor = .lightGray
        logoutButton.layer.cornerRadius = 12
        logoutButton.setTitleColor(.white, for: .normal)
    }
    
    
    private func configureTextField() {
        
        nameTextField.placeholder = "Enter your name"
        surnameTextField.placeholder = "Enter you surname"
        emailTextField.placeholder = "Enter your email"
        currentPasswordTextField.placeholder = "Entert current password"
        currentPasswordTextField.delegate = self
        newPasswordTextField.placeholder = "Enter new password"
        newPasswordTextField.alpha = 0
        newPasswordTextField.frame.origin.y = currentPasswordTextField.frame.origin.y
        confirmPasswordTextField.placeholder = "Confirm new password"
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
        
        if viewModel.changePassword(current: currentPassword,
                                    new: newPassword,
                                    confirm: confirmPassword) {
            view.endEditing(true)
            clearPaswordTextFields()
        } else {
            newPasswordTextField.text = ""
            confirmPasswordTextField.text = ""
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
