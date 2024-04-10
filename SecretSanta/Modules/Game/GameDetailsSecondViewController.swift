//
//  GameDetailsSecondViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class GameDetailsSecondViewController: UIViewController {

    
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
        label.text = "Список участников!"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [titleOfScreen, gamesTableView].forEach {
            view.addSubview($0)
        }
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.left.right.equalToSuperview().inset(40)
        }
        
        gamesTableView.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(16)
        }
    }
    
    @objc
    private func didTapCreate(){
        let vc = InviteViewController()
        vc.gameId = self.gameId
        self.navigationController?.pushViewController(vc, animated: true)
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

extension GameDetailsSecondViewController: UITableViewDelegate, UITableViewDataSource {
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

