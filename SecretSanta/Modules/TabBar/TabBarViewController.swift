//
//  TabBarViewController.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 06.04.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: Properties
    private let icons: [UIImage?] = [
        UIImage(systemName: "house"),
        UIImage(systemName: "gift"),
        UIImage(systemName: "person.circle")
    ]
    
    private var allViewControllers = [
        UINavigationController(rootViewController: HomeViewController()),
        UINavigationController(rootViewController: GameViewController()),
        UINavigationController(rootViewController: ProfileViewController())
    ]
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTabBarViews()
    }
    
    //MARK: Methods
    private func makeTabBarViews(){
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        view.backgroundColor = .white
        tabBar.tintColor = .orange
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .black
        setViewControllers(allViewControllers, animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].image = icons[i]
        }
    }
}
