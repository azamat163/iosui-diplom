//
//  habitNameLabel.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 26.11.2021.
//

import UIKit

class HabitNameLabel: UILabel {
    func apply(title: String) {
        textColor = .black
        text = title
        font = .semibold13
        textColor = .black
    }
}
