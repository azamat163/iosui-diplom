//
//  SetDateLabel.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 28.11.2021.
//

import UIKit

class SetDateLabel: UILabel {
    func apply(text: String) {
        let string = .setDateLabelText + text
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.foregroundColor, value: UIColor.purple, range: NSRange(location: 14, length: text.count))
        font = .regular17
        attributedText = attributedString
    }
}
