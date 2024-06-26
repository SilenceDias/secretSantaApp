//
//  LoginViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 05.04.2024.
//

import UIKit

class LoginViewController: UIViewController {
    private var emailText: String?
    private var passwordText: String?
    
    public var completionHandler: ((Bool) -> Void)?
    
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        title = "Войти"
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews(){
        [
            emailLabel,
            emailInput,
            passwordInput,
            passwordLabel,
            loginButton
        ].forEach {
            view.addSubview($0)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
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
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func didTapLogin(){
        emailText = emailInput.text
        passwordText = passwordInput.text
        print("Login is: \(emailText) and password: \(passwordText)")
        guard let emailText, let passwordText else {return}

        AuthManager.shared.login(email: emailText, password: passwordText) { [weak self] result in
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
    

}
