//
//  SignUpViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 04.04.2024.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private var nameText: String?
    private var passwordText: String?
    private var emailText: String?
    
    public var completionHandler: ((Bool) -> Void)?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Ваше имя"
        label.textAlignment = .left
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Ваш E-mail"
        label.textAlignment = .left
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Ваш пароль"
        label.textAlignment = .left
        return label
    }()
    
    private let nameInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите имя"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let emailInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите e-mail"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите пароль"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let signUpGoogle: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1.0)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 17.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Sign Up with Google", for: .normal)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    private let permissionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8, weight: .light)
        label.textColor = .gray
        label.text = "Регистрируясь, вы даете согласие на обработку персональных данных"
        label.textAlignment = .center
        return label
    }()
    
    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8, weight: .light)
        label.textColor = .gray
        label.text = "Уже есть аккаунт?"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        button.setTitle("Войти", for: .normal)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Войти", attributes: underlineAttribute)
        button.titleLabel?.attributedText = underlineAttributedString
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 1
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        title = "Регистрация"
        
        [
            nameLabel,
            emailLabel,
            emailInput,
            nameInput,
            signUpButton,
            signUpGoogle,
            permissionLabel,
            alreadyHaveAccountStack,
            passwordInput,
            passwordLabel
        ].forEach {
            view.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            make.left.equalToSuperview().inset(45)
        }
        nameInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(nameLabel.snp.bottom).offset(1)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(1)
            make.left.equalToSuperview().inset(45)
        }
        emailInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(emailLabel.snp.bottom).offset(1)
        }
        passwordLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(emailInput.snp.bottom).offset(1)
        }
        passwordInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(passwordLabel.snp.bottom).offset(1)
        }
        signUpGoogle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(passwordInput.snp.bottom).offset(60)
            make.height.equalTo(40)
        }
        permissionLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpGoogle.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(44)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
        
        [alreadyHaveAccountLabel, alreadyHaveAccountButton].forEach {
            alreadyHaveAccountStack.addArrangedSubview($0)
        }
        
        alreadyHaveAccountStack.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(2)
            make.left.right.equalToSuperview().inset(135)
        }
        
    }
    
    @objc
    private func didTapRegister(){
        nameText = nameInput.text
        emailText = emailInput.text
        passwordText = passwordInput.text
        print("Login is: \(emailText) and password: \(passwordText), and name :\(nameText)")
        guard let emailText, let passwordText, let nameText else {return}
        
        AuthManager.shared.register(login: nameText, email: emailText, password: passwordText) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                    self?.completionHandler?(true)
                }
            case .failure:
                let alert = UIAlertController(title: "Oops", message: "Smth went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc
    private func didTapLogin(){
        let vc = LoginViewController()
        vc.completionHandler = { [weak self] success in
            self?.handleSignIn(status: success)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(status: Bool){
        guard status else {
            let alert = UIAlertController(title: "Oops", message: "Smth went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let tabbarController = TabBarViewController()
        tabbarController.modalPresentationStyle = .fullScreen
        present(tabbarController, animated: true)
    }
    
}
