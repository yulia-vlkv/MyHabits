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

protocol HabitDetailsModuleOutput {
    
}

final class HabitDetailsPresenter: HabitDetailsModuleInput {
    
    var router: HabitDetailsRouterInput!
    var interactor: HabitDetailsInteractorInput!
    weak var view: HabitDetailsViewInput!
    
    init(view: HabitDetailsViewInput) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        return interactor.dates.count
    }
    
    func cellForItem(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
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
    
    
}
