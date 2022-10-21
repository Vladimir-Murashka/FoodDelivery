//
//  UITableVIewCell.swift
//  FoodDelivery
//
//  Created by Swift Learning on 19.10.2022.
//

import UIKit

extension UITableViewCell {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}
