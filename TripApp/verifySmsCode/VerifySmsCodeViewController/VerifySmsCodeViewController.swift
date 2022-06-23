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
    
    var phoneNumber: String!
    var password: String!
    
    // MARK: - Properties
    
    
    // MARK: - Life cycle View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - IBActions
    @IBAction func vefirySmsCodePressed(_ sender: UIButton) {
        
        guard let code = smsCodeTextField.text else { return }
        AuthManager.shared.verifyCode(smsCode: code, phoneNumber: phoneNumber, password: password) { [weak self] success in
            guard success else { return }
            guard let tabBarVC = self?.storyboard?.instantiateViewController(withIdentifier: "tabBar") as? TabBarViewController else { return }
            tabBarVC.modalPresentationStyle = .fullScreen
            self?.present(tabBarVC, animated: true)
        }
        
    }
    
    
    // MARK: - custom functions
    private func setupUI() {
        
        view.backgroundColor = mainBackgroundColor
        
        infoLabel.text = ""
        infoLabel.textColor = .white
        infoLabel.numberOfLines = 0
        
        smsCodeTextField.customConfigure(with: "Введите код в СМС", returnKey: .continue)
        smsCodeTextField.keyboardType = .numberPad
        smsCodeTextField.delegate = self
        smsCodeTextField.addTarget(self, action: #selector(smsCodeConfirm), for: .editingChanged)
        verifySmsCodeButton.grayButton(with: "Подтвердить", isEnable: true)
        
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
