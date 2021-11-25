//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 25.11.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView(frame: .zero)
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    lazy var infoView: InfoView = {
        infoView = InfoView(frame: .zero)
        infoView.toAutoLayout()
        
        return infoView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        
        scrollView.addSubview(infoView)
        view.addSubview(scrollView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            infoView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            infoView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            infoView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            infoView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
}
