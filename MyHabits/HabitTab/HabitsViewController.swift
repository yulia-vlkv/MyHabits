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
        view.backgroundColor = SelectedColors.setColor(style: .almostWhite)
        
        setNavigationBar()
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
    
    private func setStatusBarColor(color: UIColor){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = color
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
}
