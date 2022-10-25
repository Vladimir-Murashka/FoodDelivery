//
//  APIService.swift
//  FoodDelivery
//
//  Created by Swift Learning on 25.10.2022.
//

protocol APIServicable {
    func fetchPromotions(completion: @escaping (
        Result<[PromotionResponseModel],
        Error>) -> Void
    )
    func fetchCategories(completion: @escaping (
        Result<[CategoryResponseModel],
        Error>
    ) -> Void)
    func fetchProducts(completion: @escaping (
        Result<[ProductResponseModel],
        Error>
    ) -> Void)
}

final class APIService {
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension APIService: APIServicable {
    func fetchPromotions(completion: @escaping (
        Result<[PromotionResponseModel],
        Error>
    ) -> Void) {
        let urlString = "https://gist.githubusercontent.com/MrJounes/c0bf349c52fa462f1b58a7697abeec3f/raw/c66c254c715127ce6d375c7f120643fc52f510f3/promotions.json"
        networkService.request(
            urlString: urlString,
            completion: completion
        )
    }


    func fetchCategories(completion: @escaping (
        Result<[CategoryResponseModel],
        Error>
    ) -> Void) {
        let urlString = "https://gist.githubusercontent.com/MrJounes/c0bf349c52fa462f1b58a7697abeec3f/raw/c66c254c715127ce6d375c7f120643fc52f510f3/categories.json"
        networkService.request(
            urlString: urlString,
            completion: completion
        )
    }

    func fetchProducts(completion: @escaping (
        Result<[ProductResponseModel],
        Error>
    ) -> Void) {
        let urlString = "https://gist.githubusercontent.com/MrJounes/c0bf349c52fa462f1b58a7697abeec3f/raw/c66c254c715127ce6d375c7f120643fc52f510f3/products.json"
        networkService.request(
            urlString: urlString,
            completion: completion
        )
    }
}

