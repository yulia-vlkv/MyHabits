//
//  HabitDetailsRouter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation
import UIKit


protocol HabitDetailsRouterInput {
    func backToMain()
    
}

class HabitDetailsRouter: HabitDetailsRouterInput {
    
    weak var viewController: HabitDetailsViewController!
    
    func backToMain() {
        self.viewController.dismiss(animated: true)
    }
    
    func tapEditButton() {
        let habitVC = EditHabitViewController()
        guard let habit = habitVC.habit else { return }
        habitVC.habit = habit
        let navController = UINavigationController(rootViewController: habitVC)
        viewController.present(navController, animated: true)
    }
    
    func goToHabitsVC() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
