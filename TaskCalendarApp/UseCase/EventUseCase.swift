//
//  EventUseCase.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import EventKit

import RxSwift

final class EventUseCase {

    var bindAuthorizationStatus: PublishSubject<EKAuthorizationStatus> = PublishSubject.init()

    private let eventStore = EKEventStore()
    private let calendar: Calendar

    init() {
        let currentCalendar = Calendar.current
        self.calendar = currentCalendar
    }

    func requestCalendarAccessIfNeeded() {
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized:
            bindAuthorizationStatus.onNext(status)
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion: { [weak self] (granted, error) in
                if granted {
                    self?.bindAuthorizationStatus.onNext(.authorized)
                } else {
                    self?.bindAuthorizationStatus.onNext(.restricted)
                }
            })
        default:
            bindAuthorizationStatus.onNext(status)
        }
    }

    func fetchEventsInOneYear() -> Single<[DayTask]> {
        var components = DateComponents()
        components.month = 1
        let startDate = Date()
        guard let endDate = calendar.date(byAdding: components, to: Date()) else {
            return Single.just([])
        }
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let eventArray = eventStore.events(matching: predicate)

        var events = [DayTask]()
        for event in eventArray {
            let task = Task(title: event.title, stardDate: event.startDate, endDate: event.endDate, isAllDayTask: event.isAllDay, notes: event.notes)
            events.append(DayTask(tasks: [task]))
        }
        return Single.just(events)
    }
}
