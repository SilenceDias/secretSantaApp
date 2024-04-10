//
//  ProfileInfoView.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import UIKit

class ProfileInfoView: UIView {
    
    private var orangeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "orange_circle")
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private var labelStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 2
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(name: String, email: String){
        self.nameLabel.text = name
        self.emailLabel.text = email
    }
    
    private func setupViews(){
        
        self.backgroundColor = .white
        self.layer.borderColor = CGColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        self.layer.cornerRadius = 27.5
        self.layer.borderWidth = 3
        
        [nameLabel, emailLabel].forEach {
            labelStack.addArrangedSubview($0)
        }
        
        self.addSubview(orangeImage)
        self.addSubview(labelStack)
        
        orangeImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.left.equalToSuperview().inset(14)
            make.height.width.equalTo(40)
           
        }
        labelStack.snp.makeConstraints { make in
            make.left.equalTo(orangeImage.snp.right).offset(12)
            make.top.bottom.equalToSuperview().inset(4)
            make.right.equalToSuperview().inset(14)
        }

    }
}
