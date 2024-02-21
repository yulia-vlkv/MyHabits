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
    func addDate(at date: IndexPath) 
    func setTitle() -> String
}

final class HabitDetailsPresenter: HabitDetailsModuleInput {

    
    var router: HabitDetailsRouterInput!
    var interactor: HabitDetailsInteractorInput!
    weak var view: HabitDetailsViewInput!
    
    init(view: HabitDetailsViewInput, interactor: HabitDetailsInteractorInput, router: HabitDetailsRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func tapEditButton(){
        router?.tapEditButton(for: interactor.habit)
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
    
    func addDate(at date: IndexPath) {
        let selectedHabit = interactor.habit
        let item = interactor.dates.count - date.item - 1
        let selectedDate = interactor.dates[item]
        print(selectedDate)

        interactor.track(date: selectedDate, for: selectedHabit)
    }
    
    func setTitle() -> String {
        interactor.habit.name
    }
    
}
