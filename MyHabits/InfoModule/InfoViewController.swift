//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit


protocol InfoViewInput: AnyObject {
    func setupInitialState()
    func setInfoText(with text: String)
    func setInfoTitle(with title: String)
}

protocol InfoViewOutput {
    func viewDidLoad()
}

class InfoViewController: UIViewController, InfoViewInput {
    
    var output: InfoViewOutput!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        output = InfoPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
    }
    
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
        title.font = SelectedFonts.setFont(style: .title)
        title.textColor = .black
        title.textAlignment = .left
        title.toAutoLayout()
        return title
    }()
    
    private let textView: UITextView = {
        let text = UITextView()
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

    func setupInitialState(){
        
        self.title = "Информация"
        self.view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(textTitle, textView)

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

            textView.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setInfoText(with text: String) {
        textView.text = text
    }
    
    func setInfoTitle(with title: String) {
        textTitle.text = title
    }
    
}
