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

        view.backgroundColor = .lightGray
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .barTintColor
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
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
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .barTintColor
        
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = image.withTintColor(.purple, renderingMode: .automatic)
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
