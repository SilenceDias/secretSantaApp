//
//  ShuffledGameViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class ShuffledGameViewController: UIViewController {
    
    var gameId = ""
    var nameOfGame = ""
    var orgId = ""
    
    private let questionImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "question_mark")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .black
        label.text = "Жеребьевка завершена"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var showWishlistButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Узнать Подопечного", for: .normal)
        button.addTarget(self, action: #selector(didTapShow), for: .touchUpInside)
        return button
    }()
    
    private var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private var infoView = ProfileInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    

    private func setupViews(){
        
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [questionImage, buttonsStack, infoView].forEach {
            view.addSubview($0)
        }
        
        buttonsStack.addArrangedSubview(subTitleLabel)
        buttonsStack.addArrangedSubview(showWishlistButton)
        
        questionImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.right.equalToSuperview().inset(38)
        }
        
        infoView.configureView(name: nameOfGame, email: "Связаться с организатаром")
        
        buttonsStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(67)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        showWishlistButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    @objc
    private func didTapShow(){
        let vc = MyGifteeInfoViewController()
        vc.gameId = gameId
        vc.nameOfGame = nameOfGame
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
