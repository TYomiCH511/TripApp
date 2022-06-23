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
    
    @IBOutlet weak var mainConteiner: UIView!
    @IBOutlet weak var phoneCallButton: UIButton!
    @IBOutlet weak var logintTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
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
    
    
    // MARK: - Life cyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel = LoginViewModel()
        setupUI()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if UserStore.shared.getUser() != nil {
//            print("go to order VC")
//            guard let tabBar = storyboard?.instantiateViewController(withIdentifier: "tabBar") as? UITabBarController else { return }
//            tabBar.modalPresentationStyle = .fullScreen
//            present(tabBar, animated: false)
//        }
    }
    
    // MARK: - IBActions
    @IBAction func autoLoginPressed(_ sender: UISwitch) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        login()
    }
    
    @IBAction func callSupportPressed(_ sender: UIButton) {
        showPhoneAlert()
    }
    
    @IBAction func fogotPasswordButtonPressed(_ sender: UIButton) {
        print("Fogot button pressed")
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let registerVC = storyboard?.instantiateViewController(withIdentifier: "register") as? RegisterViewController else { return }
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
        
    }
    
    // MARK: - Custom function
    private func setupUI() {
        resetLoginButton()
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
        logintTextField.customConfigure(with: "+375.. номер телефона", returnKey: .next)
        passwordTextField.customConfigure(with: "Пароль", returnKey: .done)
        logintTextField.keyboardType = .phonePad
        logintTextField.delegate = self
        passwordTextField.delegate = self
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
        loginButton.grayButton(with: "Войти", isEnable: false)
        loginButton.isEnabled = false
    }
    
    private func showPhoneAlert() {
        let alert = Alert.shared.showAlertPhoneNumber()
        present(alert, animated: true)
    }
    
    private func login() {
        guard let phoneNumber = logintTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.login(with: phoneNumber, password: password) { [weak self] success in
            guard success else { return }
            
            guard let tabBar = self?.storyboard?.instantiateViewController(withIdentifier: "tabBar") as? TabBarViewController else { return }
            tabBar.modalPresentationStyle = .fullScreen
            self?.present(tabBar, animated: true) {
                
                if !(self?.autoLoginSwitch.isOn)! {
                    AuthManager.shared.singout {_ in }
                }
                
            }
                
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
        
        if !logintTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginButton.mainActionButton(with: "Войти", isEnable: true)
            loginButton.isEnabled = true
        } else {
            resetLoginButton()
        }
        
       
    }
    
}

// MARK: - Extension: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == logintTextField && textField.text == "" {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == logintTextField && textField.text?.count ?? 0 < 2  {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case logintTextField:
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
