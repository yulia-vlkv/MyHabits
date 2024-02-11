//
//  HabitDetailsRouter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation


protocol HabitDetailsRouterInput {
    func backToMain()
}

class HabitDetailsRouter: HabitDetailsRouterInput {
    
    weak var viewController: HabitDetailsViewController!
    
    func backToMain() {
        self.viewController.dismiss(animated: true)
    }
    
    @objc func tapEditButton() {
//        let habitVC = EditHabitViewController()
//        habitVC.habit = habit
//        let navController = UINavigationController(rootViewController: habitVC)
//        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func goToHabitsVC() {
//        self.navigationController?.popToRootViewController(animated: true)
    }
}
