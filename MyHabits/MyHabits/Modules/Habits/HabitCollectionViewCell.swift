//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 28.11.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
        
    static var identifier: String {
        return String(describing: self)
    }
    
    var shared: HabitsStore?
    
    var habit: Habit? {
        didSet {
            guard let habitName = habit?.name,
                  let habitDate = habit?.dateString,
                  let habitColor = habit?.color,
                  let habitTrackDates = habit?.trackDates,
                  let habitIsAlreadyTakenToday = habit?.isAlreadyTakenToday
            else { return }
            habitNameLabel.text = habitName
            habitNameLabel.textColor = habitColor
            
            habitDateLabel.text = habitDate
            
            habitCountTrackLabel.text = "\(String.counterText) \(habitTrackDates.count)"
            
            if habitIsAlreadyTakenToday == true {
                habitCheckImageView.image = UIImage(named: .checkImageName)?.withRenderingMode(.alwaysTemplate)
                habitCheckImageView.tintColor = habitColor
            } else {
                habitCheckImageView.image = UIImage(named: .ovalImageName)
                habitCheckImageView.layer.borderColor = habitColor.cgColor
                habitCheckImageView.layer.borderWidth = .borderWith
            }
        }
    }
    
    lazy var habitNameLabel: UILabel = {
        habitNameLabel = UILabel(frame: .zero)
        habitNameLabel.font = .semibold17
        habitNameLabel.textColor = .systemGray2
        habitNameLabel.numberOfLines = 2
        habitNameLabel.toAutoLayout()
        
        return habitNameLabel
    }()
    
    lazy var habitDateLabel: UILabel = {
        habitDateLabel = UILabel(frame: .zero)
        habitDateLabel.font = .regular12
        habitDateLabel.textColor = .systemGray2
        habitDateLabel.toAutoLayout()
        
        return habitDateLabel
    }()
    
    lazy var stackView: UIStackView = {
        stackView = UIStackView(arrangedSubviews: [habitNameLabel, habitDateLabel])
        stackView.spacing = .spacing
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.toAutoLayout()
        
        return stackView
    }()
    
    lazy var habitCountTrackLabel: UILabel = {
        habitCountTrackLabel = UILabel(frame: .zero)
        habitCountTrackLabel.font = .regular13
        habitCountTrackLabel.textColor = .systemGray
        habitCountTrackLabel.toAutoLayout()
        
        return habitCountTrackLabel
    }()
    
    lazy var habitCheckImageView: UIImageView = {
        habitCheckImageView = UIImageView(frame: .zero)
        habitCheckImageView.layer.cornerRadius = .cornerRadius
        habitCheckImageView.clipsToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTrackHabit))
        habitCheckImageView.addGestureRecognizer(gesture)
        habitCheckImageView.isUserInteractionEnabled = true
        habitCheckImageView.toAutoLayout()
        
        return habitCheckImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([
            stackView,
            habitCountTrackLabel,
            habitCheckImageView
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
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.trailingPadding),
            
            habitCountTrackLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            habitCountTrackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding),
            
            habitCheckImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            habitCheckImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.rightPadding),
            habitCheckImageView.widthAnchor.constraint(equalToConstant: .size),
            habitCheckImageView.heightAnchor.constraint(equalToConstant: .size)
        ])
    }
    
    @objc func handleTrackHabit() {
        guard let shared = shared else { return }
        guard let habit = habit else { return }
        
        if !habit.isAlreadyTakenToday {
            shared.track(habit)
            
            habitCheckImageView.image = UIImage(named: .checkImageName)?.withRenderingMode(.alwaysTemplate)
            habitCheckImageView.tintColor = habit.color
        }
    }
}

private extension String {
    static let checkImageName = "check-icon"
    static let ovalImageName = "oval-icon"
    static let counterText = "Счетчик: "
}

private extension CGFloat {
    static let spacing: CGFloat = 4
    static let borderWith: CGFloat = 2
    static let cornerRadius: CGFloat = 18
    static let padding: CGFloat = 20
    static let trailingPadding: CGFloat = 103
    static let rightPadding: CGFloat = 25
    static let size: CGFloat = 36
    static let contentViewCornerRadius: CGFloat = 8
}
