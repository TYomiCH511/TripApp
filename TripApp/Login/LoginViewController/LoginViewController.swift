//
//  ViewController.swift
//  TripApp
//
//  Created by Artem on 8.06.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var resetPasswordInfoLabel: UILabel!
    @IBOutlet weak var mainConteiner: UIView!
    @IBOutlet weak var phoneCallButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var autoLoginConteinerView: UIView!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var autoLoginLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - let/var property
    private var viewModel: LoginViewModelProcol! {
        didSet {
            autoLoginSwitch.isOn = viewModel.autoLogin
            viewModel.delegate = self
        }
    }
    
    private let radius = 8
    private let orderVcId = "OrderViewController"
    private var isForgotPassword: Bool = false {
        willSet (newValue){
            if newValue {
                passwordTextField.isHidden = true
                resetPasswordInfoLabel.isHidden = false
                loginButton.setTitle("Восстановить", for: .normal)
                registerButton.isHidden = true
                autoLoginConteinerView.isHidden = true
                forgotPasswordButton.setTitle("Ввести пароль", for: .normal)
            } else {
                passwordTextField.isHidden = false
                resetPasswordInfoLabel.isHidden = true
                loginButton.setTitle("Войти", for: .normal)
                registerButton.isHidden = false
                autoLoginConteinerView.isHidden = false
                forgotPasswordButton.setTitle("Забыли пароль?", for: .normal)
            }
        }
    }
    
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
        if isForgotPassword {
            resetPassword()
        } else {
            login()
        }
    }
    
    @IBAction func callSupportPressed(_ sender: UIButton) {
        showPhoneAlert()
    }
    
    @IBAction func fogotPasswordButtonPressed(_ sender: UIButton) {
        isForgotPassword.toggle()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let registerController = ViewControllers.RegisterViewController.rawValue
        guard let registerVC = storyboard?.instantiateViewController(withIdentifier: registerController) as? RegisterViewController else { return }
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
        
    }
    
    // MARK: - Custom function
    private func setupUI() {
        resetLoginButton()
        resetPasswordInfoLabel.text = "Для восстановления пароля введите номер телефона и нажмите Восстановить, после этого вам придет смс с подтверждением восстановления"
        resetPasswordInfoLabel.textColor = .white
        resetPasswordInfoLabel.numberOfLines = 0
        resetPasswordInfoLabel.isHidden = true
        loginButton.grayButton(with: "Войти", isEnable: false)
        mainConteiner.backgroundColor = .clear
        autoLoginSwitch.onTintColor = mainColor
        phoneCallButton.tintColor = mainColor
        registerButton.tintColor = mainColor
        autoLoginLabel.text = "Входить автоматически"
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        forgotPasswordButton.setTitle("Забыли пароль?", for: .normal)
        let scrollTapGesure = UITapGestureRecognizer(target: self, action: #selector(tapScrollGesture))
        mainScrollView.addGestureRecognizer(scrollTapGesure)
        mainScrollView.showsVerticalScrollIndicator = false
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupTextField()
    }
    
    
    
    private func setupTextField() {
        loginTextField.customConfigure(with: "+375.. номер телефона", returnKey: .next)
        passwordTextField.customConfigure(with: "Пароль", returnKey: .done)
        loginTextField.keyboardType = .numberPad
        loginTextField.delegate = self
        passwordTextField.delegate = self
        loginTextField.addTarget(self, action: #selector(dataOfUserNotEmpty), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(dataOfUserNotEmpty), for: .editingChanged)
    }
    
    private func clearTextField() {
        loginTextField.text = ""
        passwordTextField.text = ""
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    private func resetLoginButton() {
        loginButton.grayButton(with: "Войти", isEnable: false)
    }
    
    private func showPhoneAlert() {
        let alert = Alert.shared.showAlertPhoneNumber()
        present(alert, animated: true)
    }
    
    private func login() {
        guard let phoneNumber = loginTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.login(with: phoneNumber, password: password) { [weak self] stait in
            switch stait {
                
            case .success:
                let tabBarController = ViewControllers.TabBarViewController.rawValue
                guard let tabBar = self?.storyboard?.instantiateViewController(withIdentifier: tabBarController) as? TabBarViewController else { return }
                tabBar.modalPresentationStyle = .fullScreen
                self?.present(tabBar, animated: true) {
                    // if auto login is not enable
                    if !(self?.autoLoginSwitch.isOn)! {
                        AuthManager.shared.singout()
                    }
                }
            case .failed:
                let alert = Alert.shared.showAlert(title: "Ошибка входа",
                                                   message: "Не верный номер или пароль",
                                                   buttonTitle: "Ok") {
                    self?.passwordTextField.text = ""
                }
                self?.present(alert, animated: true)
            }
            
            
        }
    }
    
    private func resetPassword() {
        guard let phone = loginTextField.text else { return }
        viewModel.resetPassword(withPhone: phone) { [weak self] in
            let smsController = ViewControllers.VerifySmsCodeViewController.rawValue
            guard let smsVerifyVC = self?.storyboard?.instantiateViewController(withIdentifier: smsController) as? VerifySmsCodeViewController else { return }
            smsVerifyVC.modalPresentationStyle = .fullScreen
            smsVerifyVC.isResetPassword = true
            self?.present(smsVerifyVC, animated: true)
        }
    }
    
    @objc private func kbWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let difference = mainConteiner.frame.maxY - keyboardSize.origin.y
        UIView.animate(withDuration: 0.3) {
            self.mainScrollView.contentOffset = CGPoint(x: 0, y: difference)
        }
        
    }
    
    @objc private func kbWillHide() {
        mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @objc private func tapScrollGesture() {
        view.endEditing(true)
    }
    
    @objc private func dataOfUserNotEmpty(textField: UITextField) {
        
        if isForgotPassword {
            if !loginTextField.text!.isEmpty {
                loginButton.mainActionButton(with: "Войти", isEnable: true)
                loginButton.isEnabled = true
            } else {
                resetLoginButton()
            }
        } else {
            if !loginTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
                loginButton.mainActionButton(with: "Войти", isEnable: true)
                loginButton.isEnabled = true
            } else {
                resetLoginButton()
            }
        }
    }
    
}

// MARK: - Extension: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginTextField && textField.text == "" {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == loginTextField && textField.text?.count ?? 0 < 2  {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            login()
        default: break
        }
        
        return true
    }
    
    
}

extension LoginViewController: AlertLoginProtocol {
    func showAlertLoginWrong() {
        let alert = Alert.shared.showAlertWrongLogin()
        present(alert, animated: true) {
            self.passwordTextField.text = nil
        }
    }
    
}

extension LoginViewController: UIScrollViewDelegate {
    
    
}
