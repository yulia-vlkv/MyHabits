//
//  HabitTableCell.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 03.08.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
        
    var isChecked: (() -> Void)?
    
    var habit: Habit? {
        didSet {
            habitNameLabel.text = habit?.name
            habitNameLabel.textColor = habit?.color
            habitTimeLabel.text = habit?.dateString
            checkButton.layer.borderColor = habit?.color.cgColor
            counterValueLabel.text = "\(habit?.trackDates.count ?? 0)"
            
            if self.habit?.isAlreadyTakenToday == true {
                checkButton.backgroundColor = habit?.color
                checkmarkSetup()
            } else {
                checkButton.backgroundColor = .white
            }
        }
    }
    
    private let habitNameLabel: UILabel = {
        let label = UILabel()
        label.font = SelectedFonts.setFont(style: .headline)
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private let habitTimeLabel: UILabel = {
        let label = UILabel()
        label.font = SelectedFonts.setFont(style: .caption)
        label.textColor = SelectedColors.setColor(style: .lightGray)
        label.toAutoLayout()
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.font = SelectedFonts.setFont(style: .footnoteRegular)
        label.textColor = SelectedColors.setColor(style: .lightGray)
        label.text = "Счётчик: "
        label.toAutoLayout()
        return label
    }()
    
    private lazy var counterValueLabel: UILabel = {
       let label = UILabel()
        label.font = SelectedFonts.setFont(style: .footnoteRegular)
        label.textColor = SelectedColors.setColor(style: .lightGray)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 3
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(tapCheckButton), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()

// Обрабатывает нажатие на кнопку
    @objc func tapCheckButton() {
        guard let habit = habit else { return }
        
        if habit.isAlreadyTakenToday == false {
            HabitsStore.shared.track(habit)
            checkButton.backgroundColor = self.habit?.color
            checkmarkSetup()
            counterValueLabel.text = "\(habit.trackDates.count)"
            if let trackHabit = isChecked {
                trackHabit()
            }
        }
    }
        
// Меняет пустую кнопку на галочку
    func checkmarkSetup() {
        let imageSize = SelectedFonts.setFont(style: .headline)
        let configuration = UIImage.SymbolConfiguration(font: imageSize)
        let image = UIImage(systemName: "checkmark", withConfiguration: configuration)
        checkButton.setImage(image, for: .normal)
        checkButton.tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubviews(habitNameLabel, habitTimeLabel, counterLabel, counterValueLabel, checkButton)
        
        checkmarkSetup()
        
        let constraints = [
        
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -103),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            counterLabel.trailingAnchor.constraint(equalTo: counterValueLabel.leadingAnchor, constant: -1),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            counterValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            checkButton.widthAnchor.constraint(equalToConstant: 38),
            checkButton.heightAnchor.constraint(equalTo: checkButton.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

