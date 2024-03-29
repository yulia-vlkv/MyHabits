//
//  addSubviews.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 27.07.2021.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
