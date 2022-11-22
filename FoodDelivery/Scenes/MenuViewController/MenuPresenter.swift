//
//  MenuPresenter.swift
//  FoodDelivery
//
//  Created by Swift Learning on 18.10.2022.
//

import Foundation

protocol MenuPresenterProtocol: AnyObject {
    func viewDidLoad()
    func cityButtonViewPressed()
    func viewDidScrollToCell(at indexPath: IndexPath)
}

// MARK: - MenuPresenter

final class MenuPresenter {
    weak var viewController: MenuViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    private let apiService: APIServicable
    
    private var promotions: [PromotionModel] = []
    private var categories: [CategoryModel] = []
    private var products: [ProductModel] = []
    
    private var currentProductCellIndexPath = IndexPath(row: 0, section: 1)
    
    // MARK: - Initializer
    
    init(
        sceneBuildManager: Buildable,
        apiService: APIServicable
    ) {
        self.sceneBuildManager = sceneBuildManager
        self.apiService = apiService
    }
}

//MARK: - MenuPresenterExtension

extension MenuPresenter: MenuPresenterProtocol {
    func viewDidLoad() {
        DispatchQueue.global().async { [unowned self] in
            let group = DispatchGroup()
            group.enter()
            apiService.fetchPromotions { result in
                switch result {
                case .success(let response):
                    self.promotions = response.map {
                        PromotionModel($0)
                    }
                    print(response.count)

                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            }

            group.wait()
            group.enter()

            apiService.fetchCategories { result in
                switch result {
                case .success(let response):
                    self.categories = response.enumerated().map {
                        CategoryModel(
                            id: $1.id,
                            title: $1.title,
                            isSelected: $0 == 0 ? true : false
                        )
                    }
                    print(response.count)

                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            }

            group.wait()
            group.enter()

            apiService.fetchProducts { result in
                switch result {
                case .success(let response):
                    self.products = response.map {
                        ProductModel($0)
                    }
                    print(response.count)

                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            }

            group.wait()

            group.notify(queue: DispatchQueue.main) {
                self.updateSections()
            }
        }
    }
    
    func cityButtonViewPressed() {
        print("cityButtonViewPressed")
    }
    
    func viewDidScrollToCell(at indexPath: IndexPath) {
        guard currentProductCellIndexPath != indexPath else {
            return
        }
        
        currentProductCellIndexPath = indexPath
        
        let categoryId = products[indexPath.row].categoryId
        
        let categoryIndex = categories.firstIndex { category in
            category.id == categoryId
        }
        
        categories.enumerated().forEach { index, category in
            categories[index].isSelected = categoryIndex == index
        }
        
        let viewModel = makeCategoriesHeaderViewModel()
        viewController?.updateTableViewHeader(viewModel)
        
        guard let item = categoryIndex else {
            return
        }
        
        let indexPath = IndexPath(item: item, section: 0)
            
        viewController?.headerViewScrollToItem(at: indexPath)
    }
}


private extension MenuPresenter {
    func makePromotionsSection() -> Section {
        let promotionsViewModel = promotions.map { model -> PromotionCollectionViewCellViewModel in
            PromotionCollectionViewCellViewModel(imageUrl: model.imageUrl)
        }
        
        let viewModel = PromotionsTableViewCellViewModel(promotions: promotionsViewModel)
        
        let section = Section(
            type: .promotions,
            rows: [.promotions(viewModel)]
        )
        return section
    }
    
    func makeCategoriesHeaderViewModel() -> CategoriesHeaderViewModel {
        let categoriesViewModel = categories.enumerated().map { index, model in
            CategoryCellViewModel(
                title: model.title,
                isSelected: model.isSelected
            )
        }
        return CategoriesHeaderViewModel(categories: categoriesViewModel, delegate: self)
    }
    
    func makeProductsSection() -> Section {
        let categoriesViewModel = makeCategoriesHeaderViewModel()
        
        let rows = products.map { model -> RowType in
            let viewModel = ProductCellViewModel(
                title: model.title,
                descpition: model.description,
                price: "\(model.price) \(model.currency)",
                imageUrl: model.imageUrl
            )
            
            let rowType = RowType.product(viewModel)
            return rowType
        }
        let section = Section(
            type: .products(categoriesViewModel),
            rows: rows
        )
        return section
    }

    func updateSections() {
        let sections: [Section] = [
            makePromotionsSection(),
            makeProductsSection()
        ]

        viewController?.updateTableVIew(sections)
    }
}

extension MenuPresenter: CategoriesHeaderViewModelDelegate {
    func didTapCategory(at index: Int) {
        
        categories.enumerated().forEach { categoryIndex, category in
            categories[categoryIndex].isSelected = categoryIndex == index
        }
        
        let viewModel = makeCategoriesHeaderViewModel()
        viewController?.updateTableViewHeader(viewModel)
        
        let categoryId = categories[index].id
        let productIndex = products.firstIndex { product in
            product.categoryId == categoryId
        }
        guard let item = productIndex else {
            return
        }
        
        let indexPath: IndexPath = [1, item]
        viewController?.tableViewScrollToRow(at: indexPath)
    }
}
