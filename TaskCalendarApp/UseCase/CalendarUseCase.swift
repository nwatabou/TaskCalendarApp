//
//  CalendarUseCase.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import Foundation

final class CalendarUseCase {

    private let calendar = Calendar.current
    var days: [Date] = []
    var firstDate: Date! {
        didSet {
           days = createDaysForMonth()
        }
    }

    var monthString: String {
        return firstDate.string(format: "YYYY/MM")
    }

    init() {
        var component = calendar.dateComponents([.year, .month], from: Date())
        component.day = 1
        firstDate = calendar.date(from: component)
    }

    func createDaysForMonth() -> [Date] {
        // 月の初日の曜日
        let dayOfTheWeek = calendar.component(.weekday, from: firstDate) - 1
        // 月の日数
        let numberOfWeeks = calendar.range(of: .weekOfMonth, in: .month, for: firstDate)!.count
        // その月に表示する日数
        let numberOfItems = numberOfWeeks * 7

        return (0..<numberOfItems).map { i in
            var dateComponents = DateComponents()
            dateComponents.day = i - dayOfTheWeek
            return calendar.date(byAdding: dateComponents, to: firstDate)!
        }
    }

    func nextMonth() {
        firstDate = calendar.date(byAdding: .month, value: 1, to: firstDate)
    }

    func prevMonth() {
        firstDate = calendar.date(byAdding: .month, value: -1, to: firstDate)
    }
}

