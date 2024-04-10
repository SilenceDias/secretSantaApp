//
//  GameViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 07.04.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    private let titleOfScreen: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor(red: 1.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
        label.text = "Мои игры"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var games:[GamesResponse] = [] {
        didSet{
            self.gamesTableView.reloadData()
        }
    }
    
    private lazy var gamesTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(GameTableViewCell.self, forCellReuseIdentifier: "gameCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        view.addSubview(gamesTableView)
        view.addSubview(titleOfScreen)
        
        titleOfScreen.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.left.right.equalToSuperview().inset(40)
        }
        
        gamesTableView.snp.makeConstraints { make in
            make.top.equalTo(titleOfScreen.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadData(){
//        DispatchQueue.main.async {
            GamesManager.shared.getGames { [weak self] games in
                self?.games = games
            }
//        }
    }
    

}

extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gamesTableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        let game = games[indexPath.row]
        cell.configure(title: game.name, organizator: game.role, numberOfPlayer: String(game.participantCount))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        
        if game.status == "MATCHING_COMPLETED" {
            let vc = ShuffledGameViewController()
            vc.gameId = game.id
            navigationController?.pushViewController(vc, animated: true)
        }
        
        else if game.role == "PARTICIPANT" {
            let vc = GameDetailsSecondViewController()
            vc.gameId = game.id
            vc.paticipantCount = game.participantCount
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = GameDetailsViewController()
            vc.gameId = game.id
            vc.paticipantCount = game.participantCount
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    
}
