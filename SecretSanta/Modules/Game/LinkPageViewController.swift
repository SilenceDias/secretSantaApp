//
//  LinkPageViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 09.04.2024.
//

import UIKit

class LinkPageViewController: UIViewController {
    
    var gameId = ""
    
    private var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleOfScreen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textColor = .black
        label.text = "Пригласить участников"
        label.textAlignment = .center
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .black
        label.text = "Cкопируйте ссылку ниже и отправьте её своим друзьям. После перехода по ссылке, участники смогут создать карточки для участия самостоятельно"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private let titleDesktopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Desktop ссылка"
        label.textAlignment = .left
        return label
    }()
    
    private let titleIosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "IOS ссылка"
        label.textAlignment = .left
        return label
    }()
    
    private let linkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private var whiteSecondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let iosLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var copyDesktopButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = CGColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Скопировать десктоп ссылку", for: .normal)
        button.addTarget(self, action: #selector(didTapDesktop), for: .touchUpInside)
        return button
    }()
    
    private lazy var copyIosButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = CGColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Скопировать IOS ссылку", for: .normal)
        button.addTarget(self, action: #selector(didTapIos), for: .touchUpInside)
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
        loadData()
        setupViews()
        // Do any additional setup after loading the view.
    }
    

    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [
            titleOfScreen,
            subTitle,
            whiteView,
            whiteSecondView,
            titleIosLabel,
            titleDesktopLabel,
            buttonsStack
        ].forEach {
            view.addSubview($0)
        }
        
        buttonsStack.addArrangedSubview(copyDesktopButton)
        buttonsStack.addArrangedSubview(copyIosButton)
        whiteSecondView.addSubview(iosLinkLabel)
        whiteView.addSubview(linkLabel)
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.left.right.equalToSuperview().inset(40)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(40)
        }
        
        whiteView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(38)
        }
        titleDesktopLabel.snp.makeConstraints { make in
            make.bottom.equalTo(whiteView.snp.top).offset(1)
            make.left.right.equalToSuperview().inset(38)
        }
        linkLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        whiteSecondView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.bottom).offset(16)
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(38)
        }
        titleIosLabel.snp.makeConstraints { make in
            make.bottom.equalTo(whiteSecondView.snp.top).offset(1)
            make.left.right.equalToSuperview().inset(38)
        }
        iosLinkLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        buttonsStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(75)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(42)
        }
        copyIosButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        copyDesktopButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    private func loadData(){
        InvitationsManager.shared.generateLink(id: gameId) { [weak self] result in
            self?.linkLabel.text = result.link
        }
        InvitationsManager.shared.generateLinkIos(id: gameId) { [weak self] result in
            self?.iosLinkLabel.text = result.link
        }
    }
    
    @objc
    private func didTapIos(){
        let link = iosLinkLabel.text
        UIPasteboard.general.string = link
        copyIosButton.setTitle("Cсылка скопирована", for: .normal)
        copyIosButton.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        copyDesktopButton.setTitle("Скопировать десктоп ссылку", for: .normal)
        copyDesktopButton.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
    }
    
    @objc
    private func didTapDesktop(){
        let link = linkLabel.text
        UIPasteboard.general.string = link
        copyDesktopButton.setTitle("Cсылка скопирована", for: .normal)
        copyDesktopButton.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        copyIosButton.setTitle("Скопировать IOS ссылку", for: .normal)
        copyIosButton.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
    }
    

}
