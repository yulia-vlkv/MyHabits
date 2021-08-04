//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Привычки"
        view.backgroundColor = SelectedColors.setColor(style: .almostWhite)
        
        setNavigationBar()
        setTableView()
        setStatusBarColor(color: SelectedColors.setColor(style: .almostWhiteButForNavBar))
        }

    private func setNavigationBar(){
        self.navigationController!.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Сегодня"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabit))
        self.navigationController!.navigationBar.tintColor = SelectedColors.setColor(style: .awesomePurple)
        self.navigationController!.navigationBar.backgroundColor = SelectedColors.setColor(style: .almostWhiteButForNavBar)
    }

    @objc func addHabit(){
        let habitsCreateVC = HabitsCreateViewController()
        let habitsCreateNavVC = UINavigationController(rootViewController: habitsCreateVC)
        habitsCreateNavVC.modalPresentationStyle = .fullScreen
        present(habitsCreateNavVC, animated: true)
    }
    
    private func setTableView(){
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.backgroundColor = SelectedColors.setColor(style: .almostWhite)
        tableView.dataSource = self
        tableView.register(StatusTableCell.self, forCellReuseIdentifier: String(describing: StatusTableCell.self))
        tableView.register(HabitTableCell.self, forCellReuseIdentifier: String(describing: HabitTableCell.self))
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setStatusBarColor(color: UIColor){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = color
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
}

extension HabitsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: StatusTableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: StatusTableCell.self), for: indexPath) as! StatusTableCell
            // добавить что-то, чтобы передать содержание ячеек
            return cell
        } else {
            let cell: HabitTableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitTableCell.self), for: indexPath) as! HabitTableCell
            // добавить что-то, чтобы передать содержание ячеек
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
