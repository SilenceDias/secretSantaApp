//
//  InviteViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 09.04.2024.
//

import UIKit

class InviteViewController: UIViewController {
    
    var gameId = ""
    
    private let titleOfScreen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.text = "Добавить участников"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var createSelfButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderColor = CGColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0), for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        button.setTitle("Создать свою карточку участника", for: .normal)
        button.addTarget(self, action: #selector(didTapSelf), for: .touchUpInside)
        return button
    }()
    
    private lazy var addUserManuallyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderColor = CGColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0), for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        button.setTitle("Добавить участников вручную", for: .normal)
        button.addTarget(self, action: #selector(didTapManually), for: .touchUpInside)
        return button
    }()
    
    private lazy var addByLinkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderColor = CGColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0), for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        button.setTitle("Пригласить по ссылке", for: .normal)
        button.addTarget(self, action: #selector(didTapLink), for: .touchUpInside)
        return button
    }()
    
    private var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        view.addSubview(buttonsStack)
        view.addSubview(titleOfScreen)
        buttonsStack.addArrangedSubview(createSelfButton)
        buttonsStack.addArrangedSubview(addUserManuallyButton)
        buttonsStack.addArrangedSubview(addByLinkButton)
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(75)
            make.left.right.equalToSuperview().inset(40)
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(75)
        }
        
        addUserManuallyButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        createSelfButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        addByLinkButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
                         
    @objc
    private func didTapSelf(){
        let vc = CreateCardViewController()
        vc.gameId = gameId
        navigationController?.pushViewController(vc, animated: true)
    }
                         
    @objc
    private func didTapManually(){
        let vc = AddManuallyViewController()
        vc.gameId = self.gameId
        navigationController?.pushViewController(vc, animated: true)
    }
                         
    @objc
    private func didTapLink(){
        let vc = LinkPageViewController()
        vc.gameId = self.gameId
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
