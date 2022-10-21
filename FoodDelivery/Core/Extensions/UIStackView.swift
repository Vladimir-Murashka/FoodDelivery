//
//  UIStackView.swift
//  FoodDelivery
//
//  Created by Swift Learning on 18.10.2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
