//
//  HabitsStore.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit

/// Класс для хранения данных о привычке.
public final class HabitEntity: Codable {
    
    /// Название привычки.
    public var name: String
    
    /// Время выполнения привычки.
    public var date: Date
    
    /// Даты выполнения привычки.
    public var trackDates: [Date]
    
    /// Цвет привычки для выделения в списке.
    public var color: UIColor {
        get {
            return .init(red: r, green: g, blue: b, alpha: a)
        }
        set {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            newValue.getRed(&r, green: &g, blue: &b, alpha: &a)
            self.r = r
            self.g = g
            self.b = b
            self.a = a
        }
    }
    
    /// Описание времени выполнения привычки.
    public var dateString: String {
        "Каждый день в " + dateFormatter.string(from: date)
    }
    
    /// Показывает, была ли сегодня добавлена привычка.
    public var isAlreadyTakenToday: Bool {
        guard let lastTrackDate = trackDates.last else {
            return false
        }
        return calendar.isDateInToday(lastTrackDate)
    }
    
    private var r: CGFloat
    private var g: CGFloat
    private var b: CGFloat
    private var a: CGFloat
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    private lazy var calendar: Calendar = .current
    
    public init(name: String, date: Date, trackDates: [Date] = [], color: UIColor) {
        self.name = name
        self.date = date
        self.trackDates = trackDates
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}

extension HabitEntity: Equatable {
    
    public static func == (lhs: HabitEntity, rhs: HabitEntity) -> Bool {
        lhs.name == rhs.name &&
        lhs.date == rhs.date &&
        lhs.trackDates == rhs.trackDates &&
        lhs.r == rhs.r &&
        lhs.g == rhs.g &&
        lhs.b == rhs.b &&
        lhs.a == rhs.a
    }
}

