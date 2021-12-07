//
//  HabitView.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 26.11.2021.
//

import UIKit

class HabitView: UIView {
    
    var delegate: HabitViewControllerDelegate?
    var habit: Habit?

    lazy var nameLabel: HabitNameLabel = {
        nameLabel = HabitNameLabel(frame: .zero)
        nameLabel.textColor = .black
        nameLabel.apply(title: .nameLabelText)
        
        return nameLabel
    }()
    
    lazy var setNameTextField: UITextField = {
        setNameTextField = UITextField(frame: .zero)
        setNameTextField.placeholder = .placeholder
        setNameTextField.tintColor = .blue
        setNameTextField.textColor = .blue
        setNameTextField.backgroundColor = .white
        setNameTextField.font = .semibold17
        
        return setNameTextField
    }()
    
    
    lazy var colorLabel: HabitNameLabel = {
        colorLabel = HabitNameLabel(frame: .zero)
        nameLabel.textColor = .black
        colorLabel.apply(title: .colorLabelText)
        
        return colorLabel
    }()
    
    lazy var colorView: UIView = {
        colorView = UIView(frame: .zero)
        colorView.backgroundColor = .orange
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = .HabitView.cornerRadius
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleColorSelection))
        colorView.addGestureRecognizer(gesture)
        
        return colorView
    }()
    
    lazy var dateLabel: HabitNameLabel = {
        dateLabel = HabitNameLabel(frame: .zero)
        nameLabel.textColor = .black
        dateLabel.apply(title: .dateLabelText)
        
        return dateLabel
    }()
    
    lazy var setDateLabel: SetDateLabel = {
        setDateLabel = SetDateLabel(frame: .zero)
        nameLabel.textColor = .black
        setDateLabel.apply(text: convertDateToStr(with: Date()))
        
        return setDateLabel
    }()
    
    lazy var datePicker: UIDatePicker = {
        datePicker = UIDatePicker(frame: .zero)
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        
        return datePicker
    }()
    
    lazy var deleteButton: UIButton = {
        deleteButton = UIButton(frame: .zero)
        deleteButton.setTitle(.deleteButtonTitle, for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = .regular17
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        
        return deleteButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews([
            nameLabel,
            setNameTextField,
            colorLabel,
            colorView,
            dateLabel,
            setDateLabel,
            datePicker,
            deleteButton
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup constraints
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .HabitView.topPadding),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .HabitView.leftPadding),
            
            setNameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            setNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .HabitView.shortPadding),
            
            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorLabel.topAnchor.constraint(equalTo: setNameTextField.bottomAnchor, constant: .HabitView.padding),
            
            colorView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: .HabitView.shortPadding),
            colorView.widthAnchor.constraint(equalToConstant: .HabitView.colorViewWidth),
            colorView.heightAnchor.constraint(equalToConstant: .HabitView.colorViewWidth),

            
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: .HabitView.padding),
            
            setDateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            setDateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: .HabitView.shortPadding),
            
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: setDateLabel.bottomAnchor, constant: .HabitView.padding),
            datePicker.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -.HabitView.buttonPadding),
            

            deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: .HabitView.buttonHeight)
            
            
        ])
    }
    
    func configure(with habit: Habit) {
        self.habit = habit
        setNameTextField.text = habit.name
        colorView.backgroundColor = habit.color
        setDateLabel.apply(text: convertDateToStr(with: habit.date))
        datePicker.date = habit.date
        deleteButton.isHidden = false
    }
    
    @objc func handleColorSelection() {
        delegate?.handleColorSelection()
    }
    
    
    @objc func handleDateSelection() {
        setDateLabel.apply(text: convertDateToStr(with: datePicker.date))
    }
    
    @objc func deleteHabit() {
        delegate?.handleDeleteHabit()
    }
    
    private func convertDateToStr(with date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        return formatter.string(from: date)
    }
}
