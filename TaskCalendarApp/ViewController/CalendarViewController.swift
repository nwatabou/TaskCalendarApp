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
    private let cellMargin: CGFloat = 8.0
    private let insetMargin: CGFloat = 16.0
    private let daysSection: Int = 1
    private let daysCountPerWeek: Int = 7
    private var dayTasks = [DayTask]()
    private var days = [Date]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
    }

    private func initSubviews() {
        bindTapAction()
        setupCalendarView()

        viewModel.requestCalendarAccessIfNeeded()

        viewModel.bindMonthString
        .asDriver(onErrorDriveWith: Driver.empty())
        .drive(onNext: { [weak self] currentMonth in
            self?.titleLabel.text = currentMonth
        }).disposed(by: disposeBag)

        viewModel.getDaysOfMonth()
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] response in
                self?.days = response
                self?.calendarView.reloadData()
            }).disposed(by: disposeBag)
    }

    private func bindTapAction() {
        prevButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showPrevMonth()
            }).disposed(by: disposeBag)

        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showNextMonth()
            }).disposed(by: disposeBag)
    }

    private func setupCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.register(CalendarDayCell.nib, forCellWithReuseIdentifier: CalendarDayCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellMargin
        layout.minimumInteritemSpacing = cellMargin
        calendarView.collectionViewLayout = layout
    }

    private func showPrevMonth() {
        viewModel.getPrevMonth()
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] prevMonthDays in
                self?.days = prevMonthDays
                self?.calendarView.reloadData()
            }).disposed(by: disposeBag)
    }

    private func showNextMonth() {
        viewModel.getNextMonth()
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak self] nextMonthDays in
                self?.days = nextMonthDays
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

extension CalendarViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let insetsMargin: CGFloat = insetMargin * 2
        let collectionViewWedth = collectionView.frame.size.width - insetsMargin
        let width: CGFloat = (collectionViewWedth - cellMargin * numberOfMargin) / CGFloat(daysCountPerWeek)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insetMargin, left: insetMargin, bottom: insetMargin, right: insetMargin)
    }
}
