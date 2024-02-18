//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 04.08.2021.
//

import UIKit

protocol HabitDetailsViewInput: AnyObject {
    func setupInitialState()
}

protocol HabitDetailsViewOutput {
//    var habit: HabitEntity { get set }
    func viewDidLoad()
    func numberOfRowsInSection(at section: Int) -> Int
    func cellForItem(_ tableView: UITableView, at: IndexPath) -> UITableViewCell
    func changeTitle(_ view: UIViewController, for habit: HabitEntity)
    func tapEditButton()
}

class HabitDetailsViewController: UIViewController, HabitDetailsViewInput {
    
    var output: HabitDetailsModuleInput?
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let cellID = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    @objc func goToHabitsVC() {
        // To do
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setupInitialState() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = SelectedColors.setColor(style: .purple)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action:  #selector(tapEditButton))
        
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        NotificationCenter.default.addObserver(self, selector: #selector(goToHabitsVC), name: NSNotification.Name(rawValue: "goToHabitsVC"), object: nil)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tapEditButton() {
        output?.tapEditButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
//        navigationItem.title = output?.habit.name
        NotificationCenter.default.addObserver(self, selector: #selector(changeTitle), name: NSNotification.Name(rawValue: "changeTitle"), object: nil)
    }
    
    @objc func changeTitle() {
//        output?.changeTitle(self, for: habit)
    }
    
}

// MARK: - UITableViewDataSource
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.numberOfRowsInSection(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        output?.cellForItem(tableView, at: indexPath) ?? tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
}


// MARK: - UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableView.deselectRow(at: indexPath, animated: true)
    }
}

