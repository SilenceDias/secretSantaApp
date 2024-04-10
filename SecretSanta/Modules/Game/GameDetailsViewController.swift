//
//  GameDetailsViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 09.04.2024.
//

import UIKit

class GameDetailsViewController: UIViewController {
    
    var gameId = ""
    var paticipantCount = 0
    var role = ""
    
    private lazy var players:[ListOfPlayers] = [] {
        didSet{
            self.gamesTableView.reloadData()
        }
    }
    
    private lazy var gamesTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(PlayersTableViewCell.self, forCellReuseIdentifier: "playerCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let titleOfScreen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        label.text = "Игра создана!"
        label.textAlignment = .center
        return label
    }()
    
    private let santaImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "santa_pic2")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.text = "Пока что никого нет"
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .black
        label.numberOfLines = 2
        label.text = "Добавьте участников, чтоб игра началась"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var createGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Добавить участников", for: .normal)
        button.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        return button
    }()
    
    private lazy var startGameButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("Начать игру", for: .normal)
        button.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
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
        
        [titleOfScreen, buttonsStack].forEach {
            view.addSubview($0)
        }
        
        buttonsStack.addArrangedSubview(createGameButton)
        buttonsStack.addArrangedSubview(startGameButton)
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.left.right.equalToSuperview().inset(40)
        }
        
        buttonsStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(67)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        createGameButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        startGameButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        
        if paticipantCount > 0 {
            view.addSubview(gamesTableView)
            gamesTableView.snp.makeConstraints { make in
                make.top.equalTo(titleOfScreen.snp.bottom).offset(24)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(buttonsStack.snp.top).offset(16)
            }
        }
        else {
            [santaImage ,titleLabel, subTitleLabel].forEach {
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
        }
    }
    
    @objc
    private func didTapCreate(){
        let vc = InviteViewController()
        vc.gameId = self.gameId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func didTapStart(){
        GamesManager.shared.shuffleGame(gameId: gameId) { [weak self] result in
            switch result {
            case .success:
                let alert = UIAlertController(title: "Игра началась!", message: "Жеребьевка сделана!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true) {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
                return
            case .failure(let error):
                let alert = UIAlertController(title: "Ошибка", message: "Что то пошло не так", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    private func loadData(){
        GameUserManager.shared.listBeforeShuffle(gameId: gameId) { [weak self] result in
            switch result {
            case .success(let players):
                self?.players = players
            case .failure(let error):
                print(error)
            }
        }
    }
    

 
}

extension GameDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gamesTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayersTableViewCell
        let player = players[indexPath.row]
        cell.configure(name: player.user, email: player.phoneNumber ?? "Не отсавил контакты")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    
}
