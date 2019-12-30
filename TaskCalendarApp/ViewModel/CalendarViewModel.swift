//
//  CalendarViewModel.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import RxSwift

final class CalendarViewModel {

    private let eventUseCase = EventUseCase()

    func requestCalendarAccessIfNeeded() {
        eventUseCase.requestCalendarAccessIfNeeded()
    }

    func fetchEvents() -> Single<[DayTask]> {
        return eventUseCase.fetchEventsInOneYear()
    }
}
