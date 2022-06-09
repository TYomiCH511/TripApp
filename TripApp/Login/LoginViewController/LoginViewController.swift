//
//  ViewController.swift
//  TripApp
//
//  Created by Artem on 8.06.22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var logintTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var autoLoginLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - let/var property
    private var viewModel: LoginViewModelProcol! {
        didSet {
            autoLoginSwitch.isOn = viewModel.autoLogin
        }
    }
    
    private let radius = 8
    
    // MARK: - Life cyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
        setupUI()
        
    }

    // MARK: - IBActions
    @IBAction func autoLoginPressed(_ sender: UISwitch) {
       
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let phoneNumber = logintTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.fetchUser(phoneNumber: phoneNumber, password: password) { [weak self] user in
            self?.onMain {
                self?.resetLoginButton()
                self?.clearTextField()
                print(user)
                print("Go tot Main VC")
            }
        }
    }
    
    // MARK: - Custom function
    private func setupUI() {
        
        resetLoginButton()
        loginButton.layer.cornerRadius = 8
        loginButton.addShadow()
        loginButton.titleLabel!.font = .systemFont(ofSize: 32, weight: .semibold)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitleColor(.white, for: .highlighted)
        
        setupTextField()
    }
    
  
    
    private func setupTextField() {
        logintTextField.placeholder = "Enter phone number"
        passwordTextField.placeholder = "Enter password"
        
        logintTextField.addTarget(self, action: #selector(dataOfUserNotEmpty), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(dataOfUserNotEmpty), for: .editingChanged)
    }
    
    private func clearTextField() {
        logintTextField.text = ""
        passwordTextField.text = ""
        logintTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func resetLoginButton() {
        loginButton.backgroundColor = .lightGray
        loginButton.isEnabled = false
    }
    
    @objc private func dataOfUserNotEmpty() {
        
        if !logintTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = .yellow
            loginButton.isEnabled = true
        } else {
            resetLoginButton()
        }
    }
    
}

// MARK: - Extension: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
}
