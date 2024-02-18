//
//  HabitsRouter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 06.02.2024.
//

import Foundation
import UIKit

protocol HabitsRouterInput {
    func openDetail(with habit: HabitEntity)
    func openCreateHabit()
}

class HabitsRouter: HabitsRouterInput {
    
    var viewController: HabitsViewController!
    
    required init() {
        self.viewController = HabitsViewController()
    }
    
    func openDetail(with habit: HabitEntity) {
        let view = HabitDetailsViewController()
        let interactor = HabitDetailsInteractor(habit: habit)
        let router = HabitDetailsRouter()
        router.viewController = view
        let presenter = HabitDetailsPresenter(view: view, interactor: interactor, router: router)
        view.output = presenter
        viewController.navigationController?.pushViewController(view, animated: true)
    }
    
    func openCreateHabit(){
        let view = EditHabitViewController()
        let interactor = EditHabitInteractor()
        let router = EditHabitRouter()
        router.viewController = view
        let presenter = EditHabitPresenter(view: view, interactor: interactor, router: router)
        view.output = presenter
        let navController = UINavigationController(rootViewController: view)
        viewController?.present(navController, animated: true)
    }
    
}
