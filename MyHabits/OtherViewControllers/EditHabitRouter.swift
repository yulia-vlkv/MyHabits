//
//  EditHabitRouter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 11.02.2024.
//

import Foundation
import UIKit

protocol EditHabitRouterInput {
    func showAlertController()
}

class EditHabitRouter: EditHabitRouterInput {
    
    weak var viewController: EditHabitViewController!
    
    func backToMain() {
        self.viewController.dismiss(animated: true)
    }
    
    func showAlertController() {
        
        guard let habitToRemove = viewController.habit else { return }
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(habitToRemove.name)\"?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let confirm = UIAlertAction(title: "Удалить", style: .default) { (action:UIAlertAction) in
            EditHabitInteractor.shared.habits.removeAll{ $0 == self.viewController.habit }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToHabitsVC"), object: nil)
            self.viewController.dismiss(animated: true, completion: {
                let mainHabbitVC = EditHabitViewController ()
                self.viewController.present(mainHabbitVC, animated: true, completion: nil)
            })
        }
        alertController.addAction(cancel)
        alertController.addAction(confirm)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
