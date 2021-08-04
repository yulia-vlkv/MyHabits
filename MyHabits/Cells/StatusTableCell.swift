//
//  StatusTableCell.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 03.08.2021.
//

import UIKit

class StatusTableCell: UITableViewCell {
    
    private let insetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.toAutoLayout()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Всё получится!"
        label.textColor = SelectedColors.setColor(style: .lightGray)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "%"
        label.textColor = SelectedColors.setColor(style: .lightGray)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView: UIProgressView = UIProgressView()
        progressView.layer.cornerRadius = 4
        progressView.toAutoLayout()
        return progressView
    }()
    
    func setupLayout() {
        
        self.backgroundColor = SelectedColors.setColor(style: .almostWhite)
        
        contentView.addSubviews(insetView, titleLabel, percentLabel, progressView)
        backgroundView?.toAutoLayout()
    
        let constraints = [
            
            insetView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            insetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            insetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            insetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            
            titleLabel.leadingAnchor.constraint(equalTo: insetView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: insetView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10),
            
            percentLabel.trailingAnchor.constraint(equalTo: insetView.trailingAnchor, constant: -12),
            percentLabel.topAnchor.constraint(equalTo: insetView.topAnchor, constant: 10),
            percentLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10),
            
            progressView.leadingAnchor.constraint(equalTo: insetView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: insetView.trailingAnchor, constant: -12),
            progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10),
            progressView.bottomAnchor.constraint(equalTo: insetView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
}
