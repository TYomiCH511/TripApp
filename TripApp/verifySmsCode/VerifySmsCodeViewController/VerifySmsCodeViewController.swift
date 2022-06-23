//
//  VerifySmsCodeViewController.swift
//  TripApp
//
//  Created by Artem on 22.06.22.
//

import UIKit

class VerifySmsCodeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var smsCodeTextField: UITextField!
    @IBOutlet weak var verifySmsCodeButton: UIButton!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var viewModel: VerifySmsCodeViewModelProtocol!
    
    var phoneNumber: String?
    var password: String?
    var isResetPassword: Bool = true
    // MARK: - Properties
    
    
    // MARK: - Life cycle View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = VerifySmsCodeViewModel()
        setupUI()
        
    }
    
    // MARK: - IBActions
    @IBAction func vefirySmsCodePressed(_ sender: UIButton) {
        
        if isResetPassword {
            guard let code = smsCodeTextField.text else { return }
            AuthManager.shared.verifyCode(smsCode: code, phoneNumber: nil, password: nil, typeSingin: .resetPassword) { [weak self] success in
                guard success else { return }
                guard let tabBarVC = self?.storyboard?.instantiateViewController(withIdentifier: "tabBar") as? TabBarViewController else { return }
                tabBarVC.modalPresentationStyle = .fullScreen
                //self?.present(tabBarVC, animated: true)
                print("user sing in with code")
            }
            
        } else {
            guard let code = smsCodeTextField.text else { return }
            AuthManager.shared.verifyCode(smsCode: code, phoneNumber: phoneNumber, password: password, typeSingin: .newSignin) { [weak self] success in
                guard success else { return }
                guard let tabBarVC = self?.storyboard?.instantiateViewController(withIdentifier: "tabBar") as? TabBarViewController else { return }
                tabBarVC.modalPresentationStyle = .fullScreen
                self?.present(tabBarVC, animated: true)
            }
        }
        
    }
    
    @IBAction func resetPasswordPressed(_ sender: UIButton) {
        guard let newPassword = newPasswordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        viewModel.newPassword(newPassword: newPassword, confirmPassword: confirmPassword) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    
    // MARK: - custom functions
    private func setupUI() {
        
        if isResetPassword {
            verifySmsCodeButton.grayButton(with: "Восстановить", isEnable: true)
            infoLabel.text = "В течении минуты Вам придет смс сообщение в которм будет шестизначный код, для СБРОСА пароля введите код в текстовое поле"
        } else {
            verifySmsCodeButton.grayButton(with: "Подтвердить", isEnable: true)
            infoLabel.text = "В течении минуты Вам придет смс сообщение в которм будет шестизначный код, для регистрации пароля введите код в текстовое поле"
        }
        view.backgroundColor = mainBackgroundColor
        
        infoLabel.textColor = .white
        infoLabel.numberOfLines = 0
        
        smsCodeTextField.customConfigure(with: "Введите код в СМС", returnKey: .continue)
        smsCodeTextField.keyboardType = .numberPad
        smsCodeTextField.delegate = self
        smsCodeTextField.addTarget(self, action: #selector(smsCodeConfirm), for: .editingChanged)
        
        newPasswordTextField.customConfigure(with: "Введите новый пароль", returnKey: .next)
        confirmPasswordTextField.customConfigure(with: "Поддтвердите пароль", returnKey: .done)
    }
    
    
    @objc private func smsCodeConfirm() {
        if let text = smsCodeTextField.text , !text.isEmpty, text.count == 6 {
            verifySmsCodeButton.mainActionButton(with: "Подтвердить", isEnable: true)
        } else {
            verifySmsCodeButton.grayButton(with: "Подтвердить", isEnable: true)
        }
    }
}


extension VerifySmsCodeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text , !text.isEmpty, text.count == 6 {
            textField.resignFirstResponder()
            
        }
        
        return true
    }
}
