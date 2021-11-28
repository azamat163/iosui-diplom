//
//  SetDateLabel.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 28.11.2021.
//

import UIKit

class SetDateLabel: UILabel {
    func apply(text: String) {
        let string = .text + text
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 6))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 7, length: 4))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 12, length: 1))
        attributedString.addAttribute(.foregroundColor, value: UIColor.purple, range: NSRange(location: 14, length: text.count))
        font = .regular17
        attributedText = attributedString
    }
}

private extension String {
    static let text = "Каждый день в "
}
