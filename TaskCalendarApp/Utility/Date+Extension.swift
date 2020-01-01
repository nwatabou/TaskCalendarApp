//
//  Date+Extension.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/31.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
