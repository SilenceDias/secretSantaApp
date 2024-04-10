//
//  GameTableViewCell.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    private var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    private var orgLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var numberOfPlayerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .clear
        contentView.addSubview(whiteView)
        whiteView.addSubview(orgLabel)
        whiteView.addSubview(numberOfPlayerLabel)
        whiteView.addSubview(titleLabel)
        
        whiteView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(62)
            make.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.left.right.equalToSuperview().inset(64)
        }
        
        numberOfPlayerLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(57)
        }
        orgLabel.snp.makeConstraints { make in
            make.bottom.equalTo(numberOfPlayerLabel.snp.top).inset(4)
            make.left.right.equalToSuperview().inset(57)
        }
    }
    
    func configure(title: String, organizator: String, numberOfPlayer: String){
        self.titleLabel.text = title
        self.orgLabel.text = "Вы: \(organizator)"
        self.numberOfPlayerLabel.text = "Кол-во участников: \(numberOfPlayer)"
    }

}
