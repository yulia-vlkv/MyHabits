//
//  HabitDetailsPresenter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation
import UIKit


protocol HabitDetailsModuleInput: HabitDetailsInteractorOutput, HabitDetailsViewOutput {
    func viewDidLoad()
}

final class HabitDetailsPresenter: HabitDetailsModuleInput {
    
//    var habit: HabitEntity
    var router: HabitDetailsRouterInput!
    var interactor: HabitDetailsInteractorInput!
    weak var view: HabitDetailsViewInput!
    
    init(view: HabitDetailsViewInput, interactor: HabitDetailsInteractorInput, router: HabitDetailsRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
//        self.habit = habit
    }
    
//    let interactor = HabitsInteractor()
//    let router = HabitsRouter()
//    router.viewController = view
//    let presenter = HabitsPresenter(view: view, interactor: interactor, router: router)
//    view.output = presenter
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return interactor.dates.count
    }
    
    func cellForItem(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        let datesTracked = interactor.dates.count - indexPath.item - 1
        cell.textLabel?.text = interactor.trackDateString(forIndex: datesTracked)
        cell.tintColor = SelectedColors.setColor(style: .purple)
        
        let selectedHabit = interactor.habit
        let date = interactor.dates[datesTracked]
        if interactor.habit(selectedHabit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func changeTitle(_ view: UIViewController, for habit: HabitEntity) {
        view.navigationController?.navigationItem.title = habit.name
    }
    
}
