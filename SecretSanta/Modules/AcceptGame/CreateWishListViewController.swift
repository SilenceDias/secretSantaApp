//
//  CreateWishListViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class CreateWishListViewController: UIViewController {
    
    var gameId = ""
    
    private let presentOneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Подарок №1"
        label.textAlignment = .left
        return label
    }()
    
    private let presentTwoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Подарок №2"
        label.textAlignment = .left
        return label
    }()
    
    private let presentThreeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Подарок №3"
        label.textAlignment = .left
        return label
    }()
    
    private let presentOneInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите Подарок"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let presentTwoInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите Подарок"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let presentThreeInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите Подарок"
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
            presentOneInput,
            presentOneLabel,
            presentTwoInput,
            presentTwoLabel,
            signUpButton,
            presentThreeInput,
            presentThreeLabel
        ].forEach {
            view.addSubview($0)
        }
        
        presentOneLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            make.left.equalToSuperview().inset(45)
        }
        presentOneInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(presentOneLabel.snp.bottom).offset(1)
        }
        presentTwoLabel.snp.makeConstraints { make in
            make.top.equalTo(presentOneInput.snp.bottom).offset(1)
            make.left.equalToSuperview().inset(45)
        }
        presentTwoInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(presentTwoLabel.snp.bottom).offset(1)
        }
        presentThreeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(presentTwoInput.snp.bottom).offset(1)
        }
        presentThreeInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(presentThreeLabel.snp.bottom).offset(1)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func didTapNext(){
        var firstText = presentOneInput.text
        var secondText = presentTwoInput.text
        var thirdText = presentThreeInput.text
        guard let firstText, let secondText, let thirdText else {return}
        
        WishListManager.shared.sendWishList(gameId: gameId, presents: [firstText, secondText, thirdText]) { [weak self] result in
            switch result {
            case .success:
                let tabBarController = AcceptedGameViewController()
                self?.navigationController?.pushViewController(tabBarController, animated: true)
            case .failure:
                let alert = UIAlertController(title: "Oops", message: "Smth went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }

  

}
