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
    
    private var habits: [HabitEntity] = []
    
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    private lazy var userDefaults: UserDefaults = .standard
    private lazy var calendar: Calendar = .current
    
    public func getDates() -> [Date] {
        guard let startDate = userDefaults.object(forKey: "start_date") as? Date else {
            return []
        }
        return Date.dates(from: startDate, to: .init())
    }
    
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

    
    init() {
        if userDefaults.value(forKey: "start_date") == nil {
            let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date())) ?? Date()
            userDefaults.setValue(startDate, forKey: "start_date")
        }
        guard let data = userDefaults.data(forKey: "habits") else {
            return
        }
        do {
            habits = try decoder.decode([HabitEntity].self, from: data)
        }
        catch {
            print("Ошибка декодирования сохранённых привычек", error)
        }
    }
}
