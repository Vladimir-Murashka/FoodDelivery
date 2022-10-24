//
//  UICollectionViewCell.swift
//  FoodDelivery
//
//  Created by Swift Learning on 21.10.2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}
