//
//  HabitDetailsPresenter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation


protocol HabitDetailsModuleInput: HabitDetailsViewOutput {
    func viewDidLoad()
}

protocol HabitDetailsModuleOutput {

}

final class HabitDetailsPresenter: HabitDetailsModuleInput, HabitDetailsModuleOutput {
    func viewDidLoad() {
        <#code#>
    }
    
    
}
