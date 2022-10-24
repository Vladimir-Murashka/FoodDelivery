//
//  MenuViewController.swift
//  FoodDelivery
//
//  Created by Swift Learning on 17.10.2022.
//

import UIKit

// MARK: - MenuViewProtocol

protocol MenuViewProtocol: UIViewController {
    func updateTableVIew(_ sections: [Section])
}

// MARK: - MenuViewController

final class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol?
    
    // MARK: - PrivateProperties
    
    private let cityButtonView = CityBarButtonView()
    
    private lazy var tableView = make(UITableView()) { tableView in
        tableView.delegate = self
        tableView.dataSource = self
        tableView.customRegister(PromotionsTableViewCell.self)
        tableView.customRegister(ProductTableViewCell.self)
        tableView.backgroundColor = .clear
    }
    
    private var sections: [Section] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViewController()
    }
    
    // MARK: - Actions

    @objc
    private func cityButtonViewPressed() {
        cityButtonView.pushAnimate { [weak self] in
            self?.presenter?.cityButtonViewPressed()
        }
    }
}

// MARK: - MenuViewProtocol Impl

extension MenuViewController: MenuViewProtocol {
    func updateTableVIew(_ sections: [Section]) {
        self.sections = sections
        tableView.reloadData()
    }
}

// MARK: - PrivateMethods

private extension MenuViewController {
    func setupViewController() {
        view.backgroundColor = .systemGray6
        setupNavigationBar()
        addSubViews()
        setupConstraints()
    }
    
    func setupNavigationBar() {
        cityButtonView.configure(title: "Москва")
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(cityButtonViewPressed)
        )
        cityButtonView.addGestureRecognizer(gesture)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityButtonView)
    }
    
    func addSubViews() {
        view.addSubviews(tableView)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let rowType = sections[section].rows[row]
        
        switch rowType {
        case let .promotions(viewModel):
            let cell = tableView.customDequeueReusableCell(PromotionsTableViewCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel)
            return cell
        case let .product(viewModel):
            let cell = tableView.customDequeueReusableCell(ProductTableViewCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].type {
        case .promotions:
            return nil
            
        case .products(let viewModel):
            let headerView = CategoriesHeaderView()
            headerView.configureView(with: viewModel)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section].type {
        case .promotions:
            return 0
        case .products:
            return 80
        }
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
