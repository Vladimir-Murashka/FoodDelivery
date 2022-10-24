//
//  MenuPresenter.swift
//  FoodDelivery
//
//  Created by Swift Learning on 18.10.2022.
//

protocol MenuPresenterProtocol: AnyObject {
    func viewDidLoad()
    func cityButtonViewPressed()
}

// MARK: - MenuPresenter

final class MenuPresenter {
    weak var viewController: MenuViewProtocol?
    
    // MARK: - PrivateProperties
    
    private let sceneBuildManager: Buildable
    
    private var promotions: [PromotionModel] = [
        .init(id: 0, imageUrl: ""),
        .init(id: 0, imageUrl: ""),
        .init(id: 0, imageUrl: ""),
        .init(id: 0, imageUrl: ""),
        .init(id: 0, imageUrl: ""),
        .init(id: 0, imageUrl: ""),
        .init(id: 0, imageUrl: ""),
    ]
    private var categories: [CategoryModel] = [
        .init(id: 0, title: "title", isSelected: false),
        .init(id: 0, title: "title2", isSelected: true),
        .init(id: 0, title: "title3", isSelected: false),
        .init(id: 0, title: "title4", isSelected: false),
        .init(id: 0, title: "title5", isSelected: false),
        .init(id: 0, title: "title6", isSelected: false),
        .init(id: 0, title: "title7", isSelected: false),
        .init(id: 0, title: "title8", isSelected: false),
        .init(id: 0, title: "title9", isSelected: false),
    ]
    private var products: [ProductModel] = [
        .init(id: 0, title: "title", description: "description", price: 10, currency: "Р", imageUrl: ""),
        .init(id: 0, title: "title2", description: "description2", price: 10, currency: "Р", imageUrl: ""),
        .init(id: 0, title: "title3", description: "description3", price: 10, currency: "Р", imageUrl: ""),
        .init(id: 0, title: "title4", description: "description4", price: 10, currency: "Р", imageUrl: ""),
        .init(id: 0, title: "title5", description: "description5", price: 10, currency: "Р", imageUrl: ""),
        .init(id: 0, title: "title6", description: "description6", price: 10, currency: "Р", imageUrl: ""),
        .init(id: 0, title: "title7", description: "description7", price: 10, currency: "Р", imageUrl: ""),
        .init(id: 0, title: "title8", description: "description8", price: 10, currency: "Р", imageUrl: ""),
    ]
    
    // MARK: - Initializer
    
    init(sceneBuildManager: Buildable) {
        self.sceneBuildManager = sceneBuildManager
    }
}

//MARK: - MenuPresenterExtension

extension MenuPresenter: MenuPresenterProtocol {
    func viewDidLoad() {
        let sections: [Section] = [
            makePromotionsSection(),
            makeProductsSection()
        ]
        
        viewController?.updateTableVIew(sections)
    }
    
    func cityButtonViewPressed() {
        print("cityButtonViewPressed")
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
        return CategoriesHeaderViewModel(categories: categoriesViewModel)
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
}


