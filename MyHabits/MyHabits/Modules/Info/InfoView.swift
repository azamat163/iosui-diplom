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
    
    lazy var firstContentLabel: UILabel = {
        firstContentLabel = UILabel(frame: .zero)
        firstContentLabel.font = .regular17
        firstContentLabel.textColor = .black
        firstContentLabel.numberOfLines = 0
        firstContentLabel.text = .firstContentLabelText
        firstContentLabel.toAutoLayout()
        
        return firstContentLabel
    }()
    
    lazy var secondContentLabel: UILabel = {
        secondContentLabel = UILabel(frame: .zero)
        secondContentLabel.font = .regular17
        secondContentLabel.textColor = .black
        secondContentLabel.numberOfLines = 0
        secondContentLabel.text = .secondContentLabelText
        secondContentLabel.toAutoLayout()
        
        return secondContentLabel
    }()
    
    lazy var thirdContentLabel: UILabel = {
        thirdContentLabel = UILabel(frame: .zero)
        thirdContentLabel.font = .regular17
        thirdContentLabel.textColor = .black
        thirdContentLabel.numberOfLines = 0
        thirdContentLabel.text = .thirdContentLabelText
        thirdContentLabel.toAutoLayout()
        
        return thirdContentLabel
    }()
    
    lazy var fourthContentLabel: UILabel = {
        fourthContentLabel = UILabel(frame: .zero)
        fourthContentLabel.font = .regular17
        fourthContentLabel.textColor = .black
        fourthContentLabel.numberOfLines = 0
        fourthContentLabel.text = .fourthContentLabelText
        fourthContentLabel.toAutoLayout()
        
        return fourthContentLabel
    }()
    
    lazy var fifthContentLabel: UILabel = {
        fifthContentLabel = UILabel(frame: .zero)
        fifthContentLabel.font = .regular17
        fifthContentLabel.textColor = .black
        fifthContentLabel.numberOfLines = 0
        fifthContentLabel.text = .fifthContentLabelText
        fifthContentLabel.toAutoLayout()
        
        return fifthContentLabel
    }()
    
    lazy var sixthContentLabel: UILabel = {
        sixthContentLabel = UILabel(frame: .zero)
        sixthContentLabel.font = .regular17
        sixthContentLabel.textColor = .black
        sixthContentLabel.numberOfLines = 0
        sixthContentLabel.text = .sixthContentLabelText
        sixthContentLabel.toAutoLayout()
        
        return sixthContentLabel
    }()
    
    lazy var stackView: UIStackView = {
        stackView = UIStackView(arrangedSubviews: [
            firstContentLabel,
            secondContentLabel,
            thirdContentLabel,
            fourthContentLabel,
            fifthContentLabel,
            sixthContentLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = .InfoView.spacing
        stackView.distribution = .equalSpacing
        stackView.toAutoLayout()
        
        return stackView
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews([
            titleLabel,
            stackView
        ])
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .InfoView.topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .InfoView.padding),
            titleLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -.InfoView.padding),
            
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.InfoView.padding),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .InfoView.padding)
        ])
    }
}
