//
//  CalendarViewModel.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import RxSwift

final class CalendarViewModel {

    private let useCase = CalendarUseCase()

    func requestCalendarAccessIfNeeded() {
        useCase.requestCalendarAccessIfNeeded()
    }
}
