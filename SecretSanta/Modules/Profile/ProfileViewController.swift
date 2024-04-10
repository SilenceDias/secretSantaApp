//
//  ProfileViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var infoView = ProfileInfoView()
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentInset = .zero
        return scroll
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        label.text = "Личные данные"
        label.textAlignment = .center
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        label.text = "Сменить Пароль"
        label.textAlignment = .center
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Ваше имя"
        label.textAlignment = .left
        return label
    }()
    
    private let nameInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let emailInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var infoSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapSaveInfo), for: .touchUpInside)
        return button
    }()
    
    private let passwordInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Введите новый пароль"
        label.textAlignment = .left
        return label
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Повторите пароль"
        label.textAlignment = .left
        return label
    }()
    
    private let currentPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Введите нынешний пароль"
        label.textAlignment = .left
        return label
    }()
    
    private let currentPasswordInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let confirmPasswordInput: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapSavePassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Выйти", for: .normal)
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        return button
    }()
    
    private let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Удалить", for: .normal)
        return button
    }()
    
    private var contentView = UIView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupViews()
       
        // Do any additional setup after loading the view.
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.frame.width)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        [
            infoView,
            infoLabel,
            nameLabel,
            nameInput,
            emailLabel,
            emailInput,
            passwordLabel,
            passwordInputLabel,
            passwordInput,
            confirmPasswordLabel,
            confirmPasswordInput,
            currentPasswordInput,
            currentPasswordLabel,
            infoSaveButton,
            passwordSaveButton,
            logOutButton,
            deleteAccountButton
        ].forEach {
            contentView.addSubview($0)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.right.equalToSuperview().inset(38)
            make.height.equalTo(55)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoView.snp.bottom).offset(21)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.top).offset(15)
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
        infoSaveButton.snp.makeConstraints { make in
            make.top.equalTo(emailInput.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(infoSaveButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        currentPasswordLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
        }
        currentPasswordInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(currentPasswordLabel.snp.bottom).offset(1)
        }
        passwordInputLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(currentPasswordInput.snp.bottom).offset(15)
        }
        passwordInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(passwordInputLabel.snp.bottom).offset(1)
        }
        confirmPasswordLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(passwordInput.snp.bottom).offset(15)
        }
        confirmPasswordInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(1)
        }
        passwordSaveButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordInput.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(passwordSaveButton.snp.bottom).offset(74)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
        deleteAccountButton.snp.makeConstraints { make in
            make.top.equalTo(logOutButton.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(35)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func didTapLogout(){
        AuthManager.shared.removeTokens()
        let welcomeVC = WelcomeViewController()
        welcomeVC.modalPresentationStyle = .fullScreen
        present(welcomeVC, animated: true)
    }
    
    @objc
    private func didTapSaveInfo(){
        let emailText = emailInput.text
        let loginText = nameInput.text
        
        guard let emailText, let loginText else { return }
        
        ProfileManager.shared.updateEmail(newLogin: loginText, newEmail: emailText) { [weak self] result in
            switch result {
            case .success(let message):
                let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true, completion: nil)
            case .failure:
                print("error")
            }
        }
    }
    
    @objc
    private func didTapSavePassword(){
        var current = currentPasswordInput.text
        var new = passwordInput.text
        var confirm = confirmPasswordInput.text
        
        guard let current, let new, let confirm else {return}
        
        ProfileManager.shared.updatePassword(oldPassword: current, newPassword: new, confirm: confirm) { [weak self] result in
            switch result {
            case .success(let message):
                let alert = UIAlertController(title: "Пароль", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true, completion: nil)
            case .failure:
                print("error")
            }
        }
    }
    
    private func loadData(){
        ProfileManager.shared.getInfo { [weak self] result in
            switch result {
            case .success(let info):
                self?.infoView.configureView(name: info.login, email: info.email)
                self?.nameInput.placeholder = info.login
                self?.emailInput.placeholder = info.email
            case .failure(let error):
                print(error)
            }
        }
    }
}
