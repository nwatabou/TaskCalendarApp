//
//  CalendarDayCell.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {

    static let identifier: String = "dayCell"
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }

    @IBOutlet weak var dayLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func set(dayString: String) {
        dayLabel.text = dayString
    }

    func setDayOfWeek(row: Int) {
        var dayOfWeek: String
        switch row {
        case 0:
            dayOfWeek = "日"
        case 1:
            dayOfWeek = "月"
        case 2:
            dayOfWeek = "火"
        case 3:
            dayOfWeek = "水"
        case 4:
            dayOfWeek = "木"
        case 5:
            dayOfWeek = "金"
        case 6:
            dayOfWeek = "土"
        default:
            fatalError("1週間が7日ではありません")
        }
        dayLabel.text = dayOfWeek
    }
}
