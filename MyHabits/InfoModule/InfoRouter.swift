//
//  InfoRouter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation

// Абсолютно ненужный роутер, но пусть будет для практики
protocol InfoRouterInput {
    func backToMain()
}

class InfoRouter: InfoRouterInput {
    
    weak var viewController: InfoViewController!
    
    func backToMain() {
        self.viewController.dismiss(animated: true)
    }
    
}
