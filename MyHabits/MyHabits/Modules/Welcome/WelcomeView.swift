//
//  WelcomeView.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 24.11.2021.
//

import UIKit

class WelcomeView: UIView {

    private enum Constants {
        static let welcomeImage = UIImage(named: .imageName)
    }
    
    lazy var welcomeImageView: UIImageView = {
        welcomeImageView = UIImageView(frame: .zero)
        welcomeImageView.image = Constants.welcomeImage
        welcomeImageView.apply(cornerRadius: .cornerRadius)
        welcomeImageView.toAutoLayout()
        
        return welcomeImageView
    }()
    
    lazy var welcomeLabel: UILabel = {
        welcomeLabel = UILabel(frame: .zero)
        welcomeLabel.font = .semibold20
        welcomeLabel.text = .welcomeLabelText
        welcomeLabel.textColor = UIColor(named: .textColor)
        welcomeLabel.toAutoLayout()
        
        return welcomeLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews([
            welcomeImageView,
            welcomeLabel
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            welcomeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            welcomeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            welcomeImageView.widthAnchor.constraint(equalToConstant: .width),
            welcomeImageView.heightAnchor.constraint(equalToConstant: .width),
            
            welcomeLabel.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: .padding),
            welcomeLabel.leadingAnchor.constraint(equalTo: welcomeImageView.leadingAnchor)
        ])
    }
}

private extension String {
    static let imageName = "welcome-icon"
    static let welcomeLabelText = "MyHabits"
    static let textColor = "purple"
}

private extension CGFloat {
    static let width: CGFloat = 120
    static let cornerRadius: CGFloat = 27
    static let padding: CGFloat = 246
}
