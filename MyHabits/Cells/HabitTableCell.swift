//
//  HabitTableCell.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 03.08.2021.
//

import UIKit

class HabitTableCell: UITableViewCell {
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupLayout()
        contentView.backgroundColor = .cyan
    }
}
