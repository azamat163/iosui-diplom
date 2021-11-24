//
//  WelcomeViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 24.11.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    lazy var welcomeView: WelcomeView = {
        welcomeView = WelcomeView(frame: .zero)
        welcomeView.toAutoLayout()
        
        return welcomeView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(welcomeView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            welcomeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            welcomeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            welcomeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            welcomeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

