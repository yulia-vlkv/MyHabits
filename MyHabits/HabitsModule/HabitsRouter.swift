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
    
    weak var viewController: HabitsViewController!
    
    func openDetail(with habit: HabitEntity) {
        let vc = HabitDetailsViewController(habit: habit)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openCreateHabit(){
        let vc = EditHabitViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        viewController.present(navVc, animated: true)
    }
    
}
