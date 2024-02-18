//
//  EditHabitPresenter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 11.02.2024.
//

import Foundation

protocol EditHabitModuleInput: EditHabitInteractorOutput, EditHabitViewOutput {
    func viewDidLoad()
    func saveHabit()
}

final class EditHabitPresenter: EditHabitModuleInput {
    
    var router: EditHabitRouterInput!
    var interactor: EditHabitInteractorInput!
    weak var view: EditHabitViewInput!
    
    init(view: EditHabitViewInput, interactor: EditHabitInteractorInput, router: EditHabitRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view.setNavigationBar()
        view.setupInitialState()
        view.editHabit()
        view.updateSaveButtonState()
        view.setupColorPicker()
        view.chooseTime()
    }
    
    func saveHabit() {
        if let changedHabit = view.habit {
            changedHabit.name = view.habitTextField.text ?? ""
            changedHabit.date = view.timePicker.date
            changedHabit.color = view.colorButton.backgroundColor ?? .white
            interactor.save()
        } else {
            let newHabit = HabitEntity (
                name: view.habitTextField.text ?? "",
                date: view.timePicker.date,
                color: view.colorButton.backgroundColor ?? .white)
            
            let store = EditHabitInteractor.shared
            store.habits.append(newHabit)
        }
    }
    
    func showAlertController() {
        router.showAlertController()
    }
    
}
