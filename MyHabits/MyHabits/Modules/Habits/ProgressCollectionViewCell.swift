//
//  HabitProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 28.11.2021.
//

import UIKit


class ProgressCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
        
    var todayProgress: Float? {
        didSet {
            guard let progress = todayProgress else { return }
            
            statusLabel.text = stateText(with: progress)
            procentLabel.text = "\(toProcent(with: progress)) %"
            progressView.progress = progress
        }
    }
    
    lazy var statusLabel: UILabel = {
        statusLabel = UILabel(frame: .zero)
        statusLabel.font = .regular13
        statusLabel.textColor = .systemGray
        statusLabel.toAutoLayout()
        
        return statusLabel
    }()
    
    lazy var procentLabel: UILabel = {
        procentLabel = UILabel(frame: .zero)
        procentLabel.font = .regular13
        procentLabel.textColor = .systemGray
        procentLabel.toAutoLayout()
        
        return procentLabel
    }()
    
    lazy var stackView: UIStackView = {
        stackView = UIStackView(arrangedSubviews: [statusLabel, procentLabel])
        stackView.spacing = .spacing
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    lazy var progressView: UIProgressView = {
        progressView = UIProgressView(frame: .zero)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = .progressCornerRadius
        progressView.progressTintColor = .purple
        progressView.progressViewStyle = .bar
        progressView.backgroundColor = .progressColor
        progressView.toAutoLayout()
        
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([
            stackView,
            progressView
        ])
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = .contentViewCornerRadius
        contentView.clipsToBounds = true
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .topPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            
            progressView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: .bottonPadding),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
}

extension ProgressCollectionViewCell {
    func stateText(with progress: Float) -> String {
        switch progress {
        case 0..<0.5:
            return .beginStateText
        case 0.5..<1.0:
            return .middleStateText
        case 1.0...:
            return .finishStateText
        default:
            return .invalidStateText
        }
    }
    
    func toProcent(with progress: Float) -> Int {
        return Int(progress * 100)
    }
}

private extension String {
    static let beginStateText = "Давай начинать - мы верим в тебя!"
    static let middleStateText = "Все получится!"
    static let finishStateText = "Ты молодец! Все получилось!"
    static let invalidStateText = "Неизвестное состояние"

}

private extension CGFloat {
    static let spacing: CGFloat = 8
    static let progressCornerRadius: CGFloat = 3.5
    static let contentViewCornerRadius: CGFloat = 8
    static let padding: CGFloat = 12
    static let topPadding: CGFloat = 10
    static let bottonPadding: CGFloat = 15
}
