//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Привычки"
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        setNavigationBar()
        setStatusBarColor(color: UIColor(displayP3Red: 247, green: 247, blue: 247, alpha: 0.8))
        }

    private func setNavigationBar(){
        self.navigationController!.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Сегодня"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabit))
        self.navigationController!.navigationBar.tintColor = UIColor(named: "awesomePurple")
        self.navigationController!.navigationBar.backgroundColor = UIColor(displayP3Red: 247, green: 247, blue: 247, alpha: 0.8)
    }

    @objc func addHabit(){
        let habitsCreateVC = HabitsCreateViewController()
        let habitsCreateNavVC = UINavigationController(rootViewController: habitsCreateVC)
        habitsCreateNavVC.modalPresentationStyle = .fullScreen
        present(habitsCreateNavVC, animated: true)
    }
    
    private func setStatusBarColor(color: UIColor){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = color
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
}
