//
//  MyGifteeInfoViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 10.04.2024.
//

import UIKit

class MyGifteeInfoViewController: UIViewController {
    
    var gameId = ""
    var nameOfGame = ""
    
    private var infoView = ProfileInfoView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var wishlistTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(WishListTableViewCell.self, forCellReuseIdentifier: "wishCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var presents:[String] = [] {
        didSet{
            self.wishlistTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 192/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        
        [infoView, titleLabel, wishlistTableView].forEach {
            view.addSubview($0)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.right.equalToSuperview().inset(38)
        }
        
        infoView.configureView(name: nameOfGame, email: "Связаться с организатаром")
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(38)
        }
        
        wishlistTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func loadData(){
        WishListManager.shared.myGifteeData(gameId: gameId) { [weak self] result in
            switch result {
            case .success(let info):
                self?.titleLabel.text = "Карточка \(info.gifteeEmail)"
                self?.presents = info.wishlistDescriptions
            case .failure:
                print("error")
            }
        }
    }

}

extension MyGifteeInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishlistTableView.dequeueReusableCell(withIdentifier: "wishCell", for: indexPath) as! WishListTableViewCell
        let data = presents[indexPath.row]
        cell.configure(title: "Подарок №\(indexPath.row + 1)", description: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
}
