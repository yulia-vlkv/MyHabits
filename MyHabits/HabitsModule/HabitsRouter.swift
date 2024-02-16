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
        guard let viewController = viewController else { return }
        let vc = HabitDetailsViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openCreateHabit(){
        let habitVC = EditHabitViewController()
        let navController = UINavigationController(rootViewController: habitVC)
        viewController?.present(navController, animated: true)
        
//        vc.modalPresentationStyle = .fullScreen
//        viewController?.present(vc, animated: true)
    }
    
}
