//
//  WelcomeView.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 25.11.2021.
//

import UIKit

class SplashView: UIView {

    private enum Constants {
        static let splashImage = UIImage(named: .imageName)
    }
    
    lazy var splashImageView: UIImageView = {
        splashImageView = UIImageView(frame: .zero)
        splashImageView.image = Constants.splashImage
        splashImageView.toAutoLayout()
        
        return splashImageView
    }()
    
    lazy var splashLabel: UILabel = {
        splashLabel = UILabel(frame: .zero)
        splashLabel.font = .semibold20
        splashLabel.text = .welcomeLabelText
        splashLabel.textColor = .purple
        splashLabel.toAutoLayout()
        
        return splashLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        self.addSubviews([
            splashImageView,
            splashLabel
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            splashImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            splashImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            splashImageView.widthAnchor.constraint(equalToConstant: .width),
            splashImageView.heightAnchor.constraint(equalToConstant: .width),
            
            splashLabel.topAnchor.constraint(equalTo: splashImageView.bottomAnchor, constant: .padding),
            splashLabel.centerXAnchor.constraint(equalTo: splashImageView.centerXAnchor)
        ])
    }
}

private extension String {
    static let imageName = "splash-icon"
    static let welcomeLabelText = "MyHabits"
}

private extension CGFloat {
    static let width: CGFloat = 120
    static let padding: CGFloat = 246
}
