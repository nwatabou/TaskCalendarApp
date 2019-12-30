//
//  CalendarViewController.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var controllView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var calendarView: UICollectionView!

    private let viewModel = CalendarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
    }

    private func initSubviews() {
        calendarView.registerClass(cellType: CalendarDayCell.self)
        viewModel.requestCalendarAccessIfNeeded()
    }
}
