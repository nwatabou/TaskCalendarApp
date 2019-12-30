//
//  UICollectionView+Extensions.swift
//  TaskCalendarApp
//
//  Created by nakanishi wataru on 2019/12/30.
//  Copyright © 2019 nakanishi wataru. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerClass<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.getClassName())
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
       guard let cell = dequeueReusableCell(withReuseIdentifier: type.getClassName(), for: indexPath) as? T else {
           fatalError("could not dequeue cell with identifier = \(type.getClassName())")
       }
       return cell
   }
}
