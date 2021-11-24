//
//  InfoTableViewCell.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 27.07.2021.
//
//
//import UIKit
//
//class InfoTableViewCell: UITableViewCell {
//    
//    var infoText: String? {
//        didSet{
//            info.text = infoText
//        }
//    }
//    
//    private let info: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        label.textColor = .systemGray
//        label.numberOfLines = 0
//        label.toAutoLayout()
//        return label
//    }()
//    
//    private var inset: CGFloat {return 16}
//    
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        contentView.addSubview(info)
//        
//        let constraints = [
//            info.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            info.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
//            ]
//        
//        NSLayoutConstraint.activate(constraints)
//    }
//}
