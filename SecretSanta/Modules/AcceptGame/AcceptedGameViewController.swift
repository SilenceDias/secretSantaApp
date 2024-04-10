//
//  AcceptedGameViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class AcceptedGameViewController: UIViewController {
    
    private let titleOfScreen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.text = "Карточка участника создана!"
        label.textAlignment = .center
        return label
    }()
    
    private let santaImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "santa_pic3")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .black
        label.numberOfLines = 2
        label.text = "Вам придет уведомление, как только Организатор проведет жеребьевку"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var goToMainPageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("На главную", for: .normal)
        button.addTarget(self, action: #selector(didTapGoToMain), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [santaImage, titleOfScreen , subTitleLabel, goToMainPageButton].forEach {
            view.addSubview($0)
        }
        
        santaImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.left.right.equalToSuperview().inset(40)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(santaImage.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(64)
        }
        
        goToMainPageButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(67)
        }
    }
    
    @objc
    private func didTapGoToMain(){
        let tabBarController = TabBarViewController()
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true)
    }

}
