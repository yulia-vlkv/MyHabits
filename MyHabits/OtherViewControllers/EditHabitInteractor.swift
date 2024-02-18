//
//  EditHabitInteractor.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation

protocol EditHabitInteractorInput {
//    var shared: EditHabitInteractor { get }
    var habits: [HabitEntity] { get set }
    func save()
}

protocol EditHabitInteractorOutput: AnyObject {

}

/// Класс для сохранения и изменения привычек пользователя.
/// Выполняет роль интерактора для EditHabitModule и HabitDetailsModule
class EditHabitInteractor: EditHabitInteractorInput {
    
    /// Синглтон для изменения состояния привычек из разных модулей.
    public static let shared: EditHabitInteractor = .init()
    private lazy var calendar: Calendar = .current
    
    /// Список привычек, добавленных пользователем. Добавленные привычки сохраняются в UserDefaults и доступны после перезагрузки приложения.
    public var habits: [HabitEntity] = [] {
        didSet {
            save()
        }
    }
    
    /// Возвращает значение от 0 до 1.
    public var todayProgress: Float {
        guard habits.isEmpty == false else {
            return 0
        }
        let takenTodayHabits = habits.filter { $0.isAlreadyTakenToday }
        return Float(takenTodayHabits.count) / Float(habits.count)
    }
    
    private lazy var userDefaults: UserDefaults = .standard
    
    private lazy var decoder: JSONDecoder = .init()

    private lazy var encoder: JSONEncoder = .init()
    
    // Сохраняет все изменения в привычках в UserDefaults.
    public func save() {
        do {
            let data = try encoder.encode(habits)
            userDefaults.setValue(data, forKey: "habits")
        }
        catch {
            print("Ошибка кодирования привычек для сохранения", error)
        }
    }
    
    /// Добавляет текущую дату в trackDates для переданной привычки.
    /// - Parameter habit: Привычка, в которую добавится новая дата.
    public func track(_ habit: HabitEntity) {
        habit.trackDates.append(.init())
        save()
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
