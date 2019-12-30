//
//  NSObject+extension.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import Foundation

extension NSObject {
    class func getClassName() -> String {
        return String(describing: self)
    }
}
