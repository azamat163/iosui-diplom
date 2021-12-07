//
//  View+Extensions.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 24.11.2021.
//

import Foundation
import UIKit


extension UIView {
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
