//
//  HomeViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 24.11.2021.
//

import UIKit

class HomeViewController: UITabBarController {
    
    private enum Constants {
        static let habitsImage = UIImage(named: .habitsImageName)
        static let infoImage = UIImage(named: .infoImageName)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        UITabBar.appearance().barTintColor = .barTintColor
        tabBar.tintColor = .purple
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: HabitsViewController(), title: .habitsTitle, image: Constants.habitsImage!),
            createNavController(for: InfoViewController(), title: .infoTitle, image: Constants.infoImage!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = image.withTintColor(.purple, renderingMode: .automatic)
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}

private extension String {
    static let habitsTitle = "Сегодня"
    static let infoTitle = "Информация"
    static let habitsImageName = "habits-icon"
    static let infoImageName = "info-icon"
}
