//
//  CreateGameViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import UIKit

class CreateGameViewController: UIViewController {
    
    public var completionHandler: ((Bool) -> Void)?
    
    private let titleOfScreen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.text = "Мои игры"
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Название игры"
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Максимальная цена"
        label.textAlignment = .left
        return label
    }()
    
    private let nameInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let priceInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите цену"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.text = "Идентификатор"
        label.textAlignment = .left
        return label
    }()
    
    private let idInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите идентификатор"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var createGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Создать игру", for: .normal)
        button.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [
            nameLabel,
            priceLabel,
            priceInput,
            nameInput,
            createGameButton,
            idInput,
            idLabel,
            titleOfScreen
        ].forEach {
            view.addSubview($0)
        }
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.left.right.equalToSuperview().inset(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset(54)
            make.left.equalToSuperview().inset(45)
        }
        nameInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(nameLabel.snp.bottom).offset(1)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameInput.snp.bottom).offset(1)
            make.left.equalToSuperview().inset(45)
        }
        priceInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(priceLabel.snp.bottom).offset(1)
        }
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(priceInput.snp.bottom).offset(1)
            make.left.equalToSuperview().inset(45)
        }
        idInput.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(45)
            make.top.equalTo(idLabel.snp.bottom).offset(1)
        }
        createGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.left.right.equalToSuperview().inset(67)
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func didTapCreate(){
        var nameText = nameInput.text
        var priceText = priceInput.text
        var idText = idInput.text
        guard let nameText, let priceText, let idText else {return}
        
        GamesManager.shared.createGame(name: nameText, maxPrice: Int(priceText) ?? 2000, priceLimit: true, unique: idText) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
//                    self?.completionHandler?(true)
                }
            case .failure:
                let alert = UIAlertController(title: "Oops", message: "Smth went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
 

}
