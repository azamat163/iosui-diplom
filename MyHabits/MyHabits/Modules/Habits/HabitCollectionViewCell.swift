//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 28.11.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var delegate: HabitsViewControllerDelegate?
    var habit: Habit?
        
    static var identifier: String {
        return String(describing: self)
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
        stackView.spacing = .HabitCell.spacing
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
        habitCheckImageView.backgroundColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTappedImageView))
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
    
    //MARK: - configure cell
    
    func configure(with habit: Habit) {
        self.habit = habit
        habitNameLabel.text = habit.name
        habitNameLabel.textColor = habit.color
        habitDateLabel.text = habit.dateString
        habitCountTrackLabel.text = "\(String.counterText) \(habit.trackDates.count)"
        let checkImage = habit.isAlreadyTakenToday ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        habitCheckImageView.image = checkImage
        habitCheckImageView.tintColor = habit.color
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = .HabitCell.contentViewCornerRadius
        contentView.clipsToBounds = true
    }
    
    //MARK: - setup constraints
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .HabitCell.padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .HabitCell.padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.HabitCell.trailingPadding),
            
            habitCountTrackLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            habitCountTrackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.HabitCell.padding),
            
            habitCheckImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            habitCheckImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.HabitCell.rightPadding),
            habitCheckImageView.widthAnchor.constraint(equalToConstant: .HabitCell.size),
            habitCheckImageView.heightAnchor.constraint(equalToConstant: .HabitCell.size)
        ])
    }
    
    @objc func handleTappedImageView() {
        guard let habit = habit else { return }
        delegate?.imageTapped(habit)
    }
}
