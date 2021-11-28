//
//  HabitView.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 26.11.2021.
//

import UIKit

class HabitView: UIView {
    
    var delegate: HabitViewControllerDelegate?

    lazy var nameLabel: HabitNameLabel = {
        nameLabel = HabitNameLabel(frame: .zero)
        nameLabel.apply(title: .nameLabelText)
        nameLabel.toAutoLayout()
        
        return nameLabel
    }()
    
    lazy var setNameTextField: UITextField = {
        setNameTextField = UITextField(frame: .zero)
        setNameTextField.placeholder = .placeholder
        setNameTextField.tintColor = .blue
        setNameTextField.textColor = .blue
        setNameTextField.backgroundColor = .white
        setNameTextField.font = .regular17
        setNameTextField.toAutoLayout()
        
        return setNameTextField
    }()
    
    
    lazy var colorLabel: HabitNameLabel = {
        colorLabel = HabitNameLabel(frame: .zero)
        colorLabel.apply(title: .colorLabelText)
        colorLabel.toAutoLayout()
        
        return colorLabel
    }()
    
    lazy var colorView: UIView = {
        colorView = UIView(frame: .zero)
        colorView.backgroundColor = .orange
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = .cornerRadius
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleColorSelection))
        colorView.addGestureRecognizer(gesture)
        colorView.toAutoLayout()
        
        return colorView
    }()
    
    lazy var dateLabel: HabitNameLabel = {
        dateLabel = HabitNameLabel(frame: .zero)
        dateLabel.apply(title: .dateLabelText)
        dateLabel.toAutoLayout()
        
        return dateLabel
    }()
    
    lazy var setDateLabel: SetDateLabel = {
        setDateLabel = SetDateLabel(frame: .zero)
        setDateLabel.apply(text: convertDateToStr(with: Date()))
        setDateLabel.toAutoLayout()
        
        return setDateLabel
    }()
    
    lazy var datePicker: UIDatePicker = {
        datePicker = UIDatePicker(frame: .zero)
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        datePicker.toAutoLayout()
        
        return datePicker
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
            datePicker
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .topPadding),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leftPadding),
            
            setNameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            setNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: .shortPadding),
            
            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorLabel.topAnchor.constraint(equalTo: setNameTextField.bottomAnchor, constant: .padding),
            
            colorView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: .shortPadding),
            colorView.widthAnchor.constraint(equalToConstant: .colorViewWidth),
            colorView.heightAnchor.constraint(equalToConstant: .colorViewWidth),

            
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: .padding),
            
            setDateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            setDateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: .shortPadding),
            
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: setDateLabel.bottomAnchor, constant: .padding)
        ])
    }
    
    @objc func handleColorSelection() {
        delegate?.handleColorSelection()
    }
    
    
    @objc func handleDateSelection() {
        setDateLabel.apply(text: convertDateToStr(with: datePicker.date))
    }
    
    private func convertDateToStr(with date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        return formatter.string(from: date)
    }
}

private extension String {
    static let nameLabelText = "НАЗВАНИЕ"
    static let placeholder = "Бегать по утрам, спать 8 часов и т.п."
    static let colorLabelText = "ЦВЕТ"
    static let dateLabelText = "ВРЕМЯ"
    static let setDateLabelText = "Каждый день в "
}

private extension CGFloat {
    static let cornerRadius: CGFloat = 15
    static let leftPadding: CGFloat = 16
    static let topPadding: CGFloat = 21
    static let shortPadding: CGFloat = 7
    static let padding: CGFloat = 15
    static let colorViewWidth: CGFloat = 30
}