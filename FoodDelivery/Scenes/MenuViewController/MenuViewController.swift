//
//  MenuViewController.swift
//  FoodDelivery
//
//  Created by Swift Learning on 17.10.2022.
//

import UIKit

final class MenuViewController: UIViewController {
    
    // MARK: - PrivateMethods
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        view.backgroundColor = .systemYellow
    }
    
    // MARK: - Actions

}

private extension MenuViewController {
    func setupViewController() {
        view.backgroundColor = .systemGray
        setupNavigationBar()
        addSubViews()
        setupConstraints()
    }
    
    func setupNavigationBar() {}
    
    func addSubViews() {}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([])
    }
}
