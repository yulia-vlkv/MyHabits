//
//  HabitsInteractor.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 06.02.2024.
//

import Foundation

protocol HabitsInteractorInput {
    func save()
    func getHabit(with index: Int) -> HabitEntity
    func getHabitsCount() -> Int
}

protocol HabitsInteractorOutput: AnyObject {
    func habitSaved()
}

class HabitsInteractor: HabitsInteractorInput {
    
    weak var output: HabitsInteractorOutput!
    
    private var habits: [HabitEntity] {
        EditHabitInteractor.shared.habits
    }
    
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    private lazy var userDefaults: UserDefaults = .standard
    private lazy var calendar: Calendar = .current
    
    func save() {
        do {
            let data = try encoder.encode(habits)
            userDefaults.setValue(data, forKey: "habits")
            output.habitSaved()
        }
        catch {
            print("Ошибка кодирования привычек для сохранения", error)
        }
    }
    
    func getHabit(with index: Int) -> HabitEntity {
        habits[index]
    }
    
    func getHabitsCount() -> Int {
        habits.count
    }
}
