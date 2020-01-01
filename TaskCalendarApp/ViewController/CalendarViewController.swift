//
//  CalendarViewController.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class CalendarViewController: UIViewController {

    @IBOutlet weak var controllView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var calendarView: UICollectionView!

    private let viewModel = CalendarViewModel()
    private let disposeBag = DisposeBag()
    private let sectionCount: Int = 2
    private let columnTitleSection: Int = 0
    private let daysSection: Int = 1
    private let daysCountPerWeek: Int = 7
    private var dayTasks = [DayTask]()
    private var days = [Date]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
    }

    private func initSubviews() {
        calendarView.dataSource = self

        let nib = UINib(nibName: "CalendarDayCell", bundle: nil)
        calendarView.register(nib, forCellWithReuseIdentifier: CalendarDayCell.identifier)
        viewModel.requestCalendarAccessIfNeeded()

        viewModel.getDaysOfMonth()
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] response in
                self?.days = response
                self?.calendarView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension CalendarViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == columnTitleSection {
            return daysCountPerWeek
        } else {
            return days.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.identifier, for: indexPath) as! CalendarDayCell

        if indexPath.section == columnTitleSection {
            cell.setDayOfWeek(row: indexPath.row)
        } else {
            cell.set(dayString: days[indexPath.row].string(format: "d"))
        }
        return cell
    }
}
