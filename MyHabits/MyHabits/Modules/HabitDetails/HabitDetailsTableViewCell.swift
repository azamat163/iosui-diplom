//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by a.agataev on 29.11.2021.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
        
    lazy var dateLabel: UILabel = {
        dateLabel = UILabel(frame: .zero)
        dateLabel.font = .regular17
        dateLabel.textColor = .black
        dateLabel.toAutoLayout()
        
        return dateLabel
    }()
    
    lazy var dateCheckImageView: UIImageView = {
        dateCheckImageView = UIImageView(frame: .zero)
        dateCheckImageView.image = UIImage(named: .dateCheckImageName)
        dateCheckImageView.toAutoLayout()
        
        return dateCheckImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubviews([
            dateLabel,
            dateCheckImageView
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - configure cell
    
    func configure(dateString: String, isTracked: Bool) {
        dateLabel.text = dateString
        let isTrack = isTracked ? false : true
        dateCheckImageView.isHidden = isTrack
    }
    
    //MARK: - setup constraints
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .HabitDetails.leadingPadding),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dateCheckImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateCheckImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.HabitDetails.trailingPadding),
            dateCheckImageView.widthAnchor.constraint(equalToConstant: .HabitDetails.width),
            dateCheckImageView.heightAnchor.constraint(equalToConstant: .HabitDetails.height)
        ])
    }
}
