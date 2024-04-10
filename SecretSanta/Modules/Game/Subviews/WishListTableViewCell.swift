//
//  WishListTableViewCell.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    
    private var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var presentDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .black
        label.textAlignment = .left
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
        contentView.addSubview(titleLabel)
        whiteView.addSubview(presentDescription)
        
        whiteView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(38)
        }
        presentDescription.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(whiteView.snp.top).offset(1)
            make.left.right.equalToSuperview().inset(38)
        }
    }
    
    func configure(title: String, description: String){
        self.titleLabel.text = title
        self.presentDescription.text = description
    }

}
