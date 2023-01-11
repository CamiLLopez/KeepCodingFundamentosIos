//
//  HomeTabBarController.swift
//  Proyecto
//
//  Created by Oscar Rodriguez Garrucho on 13/12/22.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupTabs()
    }
    
    private func setupTabs() {
        let navigationController1 = UINavigationController(rootViewController: TableViewController())
        let tabImage = UIImage(systemName: "text.justify")!
        navigationController1.tabBarItem = UITabBarItem(title: "TableView", image: tabImage, tag: 0)
        
        let navigationController2 = UINavigationController(rootViewController: CollectionViewController())
        let tabImg = UIImage(systemName: "square.grid.3x3.topleft.filled")!
        navigationController2.tabBarItem = UITabBarItem(title: "CollectionView", image: tabImg, tag: 1)
        
        viewControllers = [navigationController1, navigationController2]
    }
    
    private func setupLayout() {
        tabBar.backgroundColor = .systemBackground
    }

}
