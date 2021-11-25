//
//  WelcomeViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 24.11.2021.
//

import UIKit

class SplashViewController: UIViewController {
    
    lazy var splashView: SplashView = {
        splashView = SplashView(frame: .zero)
        splashView.toAutoLayout()
        
        return splashView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(splashView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            splashView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            splashView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            splashView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            splashView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

