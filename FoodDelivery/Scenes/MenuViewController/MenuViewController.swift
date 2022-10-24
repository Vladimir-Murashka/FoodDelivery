//
//  MenuViewController.swift
//  FoodDelivery
//
//  Created by Swift Learning on 17.10.2022.
//

import UIKit

// MARK: - MenuViewProtocol

protocol MenuViewProtocol: UIViewController {}

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
    }
    
    private var sections: [Section] = [
        Section.init(
            type: .promotions,
            rows: [
                .promotions(
                    PromotionsTableViewCellViewModel(promotions: [
                        .init(imageUrl: ""),
                        .init(imageUrl: ""),
                        .init(imageUrl: ""),
                        .init(imageUrl: ""),
                        .init(imageUrl: ""),
                        .init(imageUrl: ""),
                        .init(imageUrl: "")
                    ])
                )
            ]
        ),
        Section.init(
            type: .products(
                CategoriesHeaderViewModel(categories: [
                    CategoryCellViewModel(title: "Пацца", isSelected: true),
                    CategoryCellViewModel(title: "Хинкали", isSelected: false),
                    CategoryCellViewModel(title: "Десерты", isSelected: false),
                    CategoryCellViewModel(title: "Мангал", isSelected: false),
                    CategoryCellViewModel(title: "Выпечка", isSelected: false),
                    CategoryCellViewModel(title: "Суши", isSelected: false),
                    CategoryCellViewModel(title: "Роллы", isSelected: false),
                    CategoryCellViewModel(title: "Напитки", isSelected: false),
                ])),
            rows: [
                .product(
                    ProductCellViewModel(
                        title: "Ветчина и грибы",
                        descpition: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус",
                        price: "от 345 р",
                        imageUrl: ""
                    )
                ),
                .product(
                    ProductCellViewModel(
                        title: "Ветчина",
                        descpition: "Ветчина,шампиньоны",
                        price: "от 145 р",
                        imageUrl: ""
                    )
                ),
                .product(
                    ProductCellViewModel(
                        title: "Ветчина и грибы",
                        descpition: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус",
                        price: "от 345 р",
                        imageUrl: ""
                    )
                ),
                .product(
                    ProductCellViewModel(
                        title: "Ветчина и грибы",
                        descpition: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус",
                        price: "от 345 р",
                        imageUrl: ""
                    )
                )
            ]
        )
    ]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension MenuViewController: MenuViewProtocol {}

// MARK: - PrivateMethods

private extension MenuViewController {
    func setupViewController() {
        view.backgroundColor = .systemBackground
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
