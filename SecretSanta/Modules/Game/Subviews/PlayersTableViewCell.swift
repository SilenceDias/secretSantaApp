//
//  PlayersTableViewCell.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {
    
    private var playerView = ProfileInfoView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(playerView)
        backgroundColor = .clear
        playerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(28)
            make.height.equalTo(50)
        }
    }
    
    func configure(name: String, email: String){
        self.playerView.configureView(name: name, email: email)
    }

}
