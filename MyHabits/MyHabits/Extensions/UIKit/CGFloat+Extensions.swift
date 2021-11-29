//
//  CGFloat+Extensions.swift
//  MyHabits
//
//  Created by a.agataev on 29.11.2021.
//

import Foundation
import UIKit

extension CGFloat {
    
    enum HabitView {
        static let cornerRadius: CGFloat = 15
        static let leftPadding: CGFloat = 16
        static let topPadding: CGFloat = 21
        static let shortPadding: CGFloat = 7
        static let padding: CGFloat = 15
        static let colorViewWidth: CGFloat = 30
    }
    
    enum CollectionView {
        static let progressEstimated: CGFloat = 60
        static let mainEstimated: CGFloat = 130
        static let interGroupSpacing: CGFloat = 12
    }
    
    enum InfoView {
        static let topPadding: CGFloat = 22
        static let padding: CGFloat = 16
        static let spacing: CGFloat = 12
    }
    
    enum HabitDetails {
        static let padding: CGFloat = 11
        static let leadingPadding: CGFloat = 16
        static let trailingPadding: CGFloat = 14
        static let width: CGFloat = 26
        static let height: CGFloat = 44
    }
}
