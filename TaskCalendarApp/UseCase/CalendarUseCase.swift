//
//  CalendarUseCase.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import EventKit

import RxSwift

final class CalendarUseCase {

    var bindAuthorizationStatus: PublishSubject<EKAuthorizationStatus> = PublishSubject.init()

    private let eventStore = EKEventStore()

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
}
