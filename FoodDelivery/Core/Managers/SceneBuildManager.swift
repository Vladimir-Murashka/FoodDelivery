//
//  File.swift
//  FoodDelivery
//
//  Created by Swift Learning on 18.10.2022.
//

protocol Buildable {
    func buildMenuScreen() -> MenuViewController
    func buildTabBarScreen() -> TabBarController
}

final class SceneBuildManager {
    private let apiService: APIServicable
    private let networkService: NetworkService
    private let decoderService: Decoderable

    init() {
        decoderService = DecoderService()
        networkService = NetworkService(decoderService: decoderService)
        apiService = APIService(networkService: networkService)
    }
}

extension SceneBuildManager: Buildable {
    func buildTabBarScreen() -> TabBarController {
        let viewController = TabBarController()
        
        return viewController
    }
    
    func buildMenuScreen() -> MenuViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter(
            sceneBuildManager: self,
            apiService: apiService
        )
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
