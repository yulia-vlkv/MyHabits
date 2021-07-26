//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Информация"
        self.view.backgroundColor = .white
        
        setUpTableView()
    }
    
    private func setUpTableView(){
        
    }
}

// MARK: extension toAutoLayout
extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: extension addSubviews
extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
