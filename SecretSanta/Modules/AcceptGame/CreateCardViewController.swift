//
//  CreateCardViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class CreateCardViewController: UIViewController {
    
    var gameId = ""
    
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
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Ваш номер"
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
    
    private let phoneInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите номер телефона"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [
            nameLabel,
            emailLabel,
            emailInput,
            nameInput,
            signUpButton,
            phoneInput,
            phoneLabel
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
        phoneLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(emailInput.snp.bottom).offset(1)
        }
        phoneInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(phoneLabel.snp.bottom).offset(1)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func didTapNext(){
        var nameText = nameInput.text
        var emailText = emailInput.text
        var phoneText = phoneInput.text
        guard let emailText, let phoneText, let nameText else {return}
        GameUserManager.shared.sendContactInfo(gameId: gameId, name: nameText, email: emailText, phone: phoneText) { [weak self] result in
            switch result {
            case .success:
                let vc = CreateWishListViewController()
                vc.gameId = self?.gameId ?? ""
                self?.navigationController?.pushViewController(vc, animated: true)
            case .failure:
                let alert = UIAlertController(title: "Oops", message: "Smth went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }


}
