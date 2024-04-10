//
//  AcceptGameViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class AcceptGameViewController: UIViewController {
    
    var link = ""
    var gameId = ""
    
    private let santaImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "santa_pic")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var acceptGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Создать карточку участника", for: .normal)
        button.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [santaImage, acceptGameButton].forEach {
            view.addSubview($0)
        }
        
        santaImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        acceptGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(67)
        }
    }
    
    @objc
    private func didTapAccept(){
        InvitationsManager.shared.acceptInvite(link: link) { [weak self] result in
            switch result {
            case .success(let info):
                let vc = CreateCardViewController()
                vc.gameId = info.gameId
                self?.navigationController?.pushViewController(vc, animated: true)
                print(info.message)
            case .failure(let error):
                print(error)
            }
        }

    }
    
    private func acceptGame(link: String){
        
    }

}
