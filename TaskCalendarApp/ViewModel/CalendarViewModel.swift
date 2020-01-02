//
//  CalendarViewModel.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import RxSwift
import RxCocoa

final class CalendarViewModel {

    private let calendarUseCase = CalendarUseCase()
    private let eventUseCase = EventUseCase()

    var bindMonthString = PublishRelay<String>()

    func getDaysOfMonth() -> Single<[Date]> {
        let days = calendarUseCase.createDaysForMonth()
        bindMonthString.accept(calendarUseCase.monthString)
        return Single.just(days)
    }

    func getPrevMonth() -> Single<[Date]> {
        let days = calendarUseCase.prevMonth()
        bindMonthString.accept(calendarUseCase.monthString)
        return Single.just(days)
    }

    func getNextMonth() -> Single<[Date]> {
        let days = calendarUseCase.nextMonth()
        bindMonthString.accept(calendarUseCase.monthString)
        return Single.just(days)
    }

    func requestCalendarAccessIfNeeded() {
        eventUseCase.requestCalendarAccessIfNeeded()
    }

    func fetchEvents() -> Single<[DayTask]> {
        return eventUseCase.fetchEventsInOneYear()
    }
}
