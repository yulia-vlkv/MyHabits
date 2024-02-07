//
//  HabitsStore.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation


/// Класс для сохранения и изменения привычек пользователя.
/// Выполняет роль интерактора для EditHabitModule и HabitDetailsModule
public final class HabitsStore {
    
    /// Синглтон для изменения состояния привычек из разных модулей.
    public static let shared: HabitsStore = .init()
    
    /// Список привычек, добавленных пользователем. Добавленные привычки сохраняются в UserDefaults и доступны после перезагрузки приложения.
    public var habits: [HabitEntity] = [] {
        didSet {
//            save()
        }
    }
    
    /// Даты с момента установки приложения с разницей в один день.
//    public var dates: [Date] {
//        guard let startDate = userDefaults.object(forKey: "start_date") as? Date else {
//            return []
//        }
//        return Date.dates(from: startDate, to: .init())
//    }
    
    /// Возвращает значение от 0 до 1.
    public var todayProgress: Float {
        guard habits.isEmpty == false else {
            return 0
        }
        let takenTodayHabits = habits.filter { $0.isAlreadyTakenToday }
        return Float(takenTodayHabits.count) / Float(habits.count)
    }
    
//    private lazy var userDefaults: UserDefaults = .standard
    
//    private lazy var decoder: JSONDecoder = .init()
//
//    private lazy var encoder: JSONEncoder = .init()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    private lazy var calendar: Calendar = .current
    
    // MARK: - Lifecycle
    
    /// Сохраняет все изменения в привычках в UserDefaults.
//    public func save() {
//        do {
//            let data = try encoder.encode(habits)
//            userDefaults.setValue(data, forKey: "habits")
//        }
//        catch {
//            print("Ошибка кодирования привычек для сохранения", error)
//        }
//    }
    
    /// Добавляет текущую дату в trackDates для переданной привычки.
    /// - Parameter habit: Привычка, в которую добавится новая дата.
//    public func track(_ habit: HabitEntity) {
//        habit.trackDates.append(.init())
//        save()
//    }
    
    /// Возвращает отформатированное время для даты.
    /// - Parameter index: Индекс в массиве dates.
//    public func trackDateString(forIndex index: Int) -> String? {
//        guard index < dates.count else {
//            return nil
//        }
//        return dateFormatter.string(from: dates[index])
//    }
//
    /// Показывает, была ли затрекана привычка в переданную дату.
    /// - Parameters:
    ///   - habit: Привычка, у которой проверяются затреканные даты.
    ///   - date: Дата, для которой проверяется, была ли затрекана привычка.
    /// - Returns: Возвращает true, если привычка была затрекана в переданную дату.
    public func habit(_ habit: HabitEntity, isTrackedIn date: Date) -> Bool {
        habit.trackDates.contains { trackDate in
            calendar.isDate(date, equalTo: trackDate, toGranularity: .day)
        }
    }
    
    // MARK: - Private
    
//    private init() {
//        if userDefaults.value(forKey: "start_date") == nil {
//            let startDate = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: Date())) ?? Date()
//            userDefaults.setValue(startDate, forKey: "start_date")
//        }
//        guard let data = userDefaults.data(forKey: "habits") else {
//            return
//        }
//        do {
//            habits = try decoder.decode([HabitEntity].self, from: data)
//        }
//        catch {
//            print("Ошибка декодирования сохранённых привычек", error)
//        }
//    }
}
