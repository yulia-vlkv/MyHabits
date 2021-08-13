//
//  StatusTableCell.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 03.08.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Всё получится!"
        label.textColor = SelectedColors.setColor(style: .lightGray)
        label.font = SelectedFonts.setFont(style: .FootnoteRegular)
        label.toAutoLayout()
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = SelectedColors.setColor(style: .lightGray)
        label.font = SelectedFonts.setFont(style: .FootnoteBold)
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()
    private let progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.trackTintColor = SelectedColors.setColor(style: .lightGray)
        progressBar.progressTintColor = SelectedColors.setColor(style: .awesomePurple)
        progressBar.toAutoLayout()
        return progressBar
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateProgress()
        setupViews()
    }
    
    func updateProgress() {
        progressBar.setProgress(HabitsStore.shared.todayProgress, animated: false)
        percentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
    }
    
    func setupViews() {
        
        contentView.addSubviews(titleLabel, percentLabel, progressBar)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
    
        let constraints = [
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: percentLabel.trailingAnchor, constant: -8),
            
            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
