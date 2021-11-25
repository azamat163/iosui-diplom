//
//  infoView.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 26.11.2021.
//

import UIKit

class InfoView: UIView {

    lazy var titleLabel: UILabel = {
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = .semibold20
        titleLabel.textColor = .black
        titleLabel.text = .titleLabelText
        titleLabel.toAutoLayout()
        
        return titleLabel
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .padding)
        ])
    }
}

private extension String {
    static let titleLabelText = "Привычка за 21 день"
}

private extension CGFloat {
    static let topPadding: CGFloat = 22
    static let padding: CGFloat = 16
}
