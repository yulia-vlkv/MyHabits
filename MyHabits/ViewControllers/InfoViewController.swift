//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.toAutoLayout()
        return scroll
    }()
    
    private let contentView: UIView = {
            let mainView = UIView()
            mainView.backgroundColor = .white
            mainView.toAutoLayout()
            return mainView
    }()
    
    private let textTitle: UILabel = {
        let title = UILabel()
        title.text = infoTitle
        title.font = SelectedFonts.setFont(style: .title)
        title.textColor = .black
        title.textAlignment = .left
        title.toAutoLayout()
        return title
    }()
    
    private let text: UITextView = {
        let text = UITextView()
        text.text = infoText
        text.textColor = .black
        text.textAlignment = .left
        text.isScrollEnabled = false
        let padding = text.textContainer.lineFragmentPadding
        text.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        let style = NSMutableParagraphStyle()
        style.paragraphSpacing = 12
        let attributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: SelectedFonts.setFont(style: .body)]
        text.attributedText = NSAttributedString(string: text.text, attributes: attributes)
        text.toAutoLayout()
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Информация"
        self.view.backgroundColor = .white
        
        setupTextView()
    }

    private func setupTextView(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(textTitle, text)

        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            textTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            textTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            text.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 16),
            text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
