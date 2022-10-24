//
//  UITableView.swift
//  FoodDelivery
//
//  Created by Swift Learning on 19.10.2022.
//

import UIKit

extension UITableView {
    func customRegister<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func customDequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseId, for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) not found")
        }
        return cell
    }
}
