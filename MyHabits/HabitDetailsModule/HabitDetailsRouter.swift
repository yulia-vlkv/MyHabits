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
    func tapEditButton(for habit: HabitEntity?)
    
}

class HabitDetailsRouter: HabitDetailsRouterInput {
    
    weak var viewController: HabitDetailsViewController!
    
    func backToMain() {
        self.viewController.dismiss(animated: true)
    }
    
    func tapEditButton(for habit: HabitEntity?) {
        let habitVC = EditHabitViewController()
        let interactor = EditHabitInteractor()
        let router = EditHabitRouter()
        router.viewController = habitVC
        let presenter = EditHabitPresenter(view: habitVC, interactor: interactor, router: router)
        habitVC.output = presenter
        guard let habit = habit else { return }
        habitVC.habit = habit
        let navController = UINavigationController(rootViewController: habitVC)
        viewController.present(navController, animated: true)
    }
    
    func goToHabitsVC() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
