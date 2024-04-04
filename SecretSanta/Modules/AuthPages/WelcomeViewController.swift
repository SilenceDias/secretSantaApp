//
//  ViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 04.04.2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    private let santaImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "santa_pic")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        label.text = "Тайный Санта"
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .black
        label.numberOfLines = 2
        label.text = "Организуй тайный обмен подарками между друзьями или коллегами"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [santaImage, titleLabel, subTitleLabel, signUpButton].forEach {
            view.addSubview($0)
        }
        
        santaImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(santaImage.snp.bottom).offset(26)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(64)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(67)
        }
    }
    
    @objc
    private func didTapSignUp(){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

