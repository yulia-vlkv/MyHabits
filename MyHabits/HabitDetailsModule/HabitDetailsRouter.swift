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
    
    weak var viewController: InfoViewController!
    
    func backToMain() {
        self.viewController.dismiss(animated: true)
    }
}
