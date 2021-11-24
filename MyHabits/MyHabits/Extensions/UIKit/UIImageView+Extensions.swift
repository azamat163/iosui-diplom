//
//  ImageView+Extensions.swift
//  MyHabits
//
//  Created by Азамат Агатаев on 24.11.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func apply(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
