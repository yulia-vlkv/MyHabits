//
//  FoundationExtention.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 06.02.2024.
//

import Foundation

extension Date {
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else {
                break
            }
            date = newDate
        }
        return dates
    }
}
