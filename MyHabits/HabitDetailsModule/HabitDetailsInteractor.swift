//
//  HabitDetailsInteractor.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation

protocol HabitDetailsInteractorInput {
    var habit: HabitEntity { get }
    var dates: [Date] { get }
    func trackDateString(forIndex index: Int) -> String? 
    func habit(_ habit: HabitEntity, isTrackedIn date: Date) -> Bool 
}

protocol HabitDetailsInteractorOutput: AnyObject {

}

class HabitDetailsInteractor: HabitDetailsInteractorInput {

    weak var output: HabitDetailsInteractorOutput!
    
    var habit: HabitEntity
    
    init (habit: HabitEntity) {
        self.habit = habit
    }
    
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    private lazy var userDefaults: UserDefaults = .standard
    private lazy var calendar: Calendar = .current
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    /// Даты с момента установки приложения с разницей в один день.
    var dates: [Date] {
        guard let startDate = userDefaults.object(forKey: "start_date") as? Date else {
            return []
        }
        return Date.dates(from: startDate, to: .init())
    }
    
    /// Возвращает отформатированное время для даты.
    /// - Parameter index: Индекс в массиве dates.
    func trackDateString(forIndex index: Int) -> String? {
        guard index < dates.count else {
            return nil
        }
        return dateFormatter.string(from: dates[index])
    }
    
    /// Показывает, была ли затрекана привычка в переданную дату.
    /// - Parameters:
    ///   - habit: Привычка, у которой проверяются затреканные даты.
    ///   - date: Дата, для которой проверяется, была ли затрекана привычка.
    /// - Returns: Возвращает true, если привычка была затрекана в переданную дату.
    func habit(_ habit: HabitEntity, isTrackedIn date: Date) -> Bool {
        habit.trackDates.contains { trackDate in
            calendar.isDate(date, equalTo: trackDate, toGranularity: .day)
        }
    }

}
