//
//  AddManuallyViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 09.04.2024.
//

import UIKit

class AddManuallyViewController: UIViewController {
    
    var gameId = ""
    
    private let titleOfScreen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textColor = .black
        label.text = "Пригласить участников"
        label.textAlignment = .center
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .black
        label.text = "Cсылка придет на почту вашим друзьям"
        label.textAlignment = .center
        label.numberOfLines = 3
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
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Ваш E-mail"
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
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
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
            submitButton,
            titleOfScreen,
            subTitle
        ].forEach {
            view.addSubview($0)
        }
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.left.right.equalToSuperview().inset(40)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(40)
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
        submitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func didTapSubmit(){
        
    }
    
}
