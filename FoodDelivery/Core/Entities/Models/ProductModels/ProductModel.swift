//
//  ProductModel.swift
//  FoodDelivery
//
//  Created by Swift Learning on 24.10.2022.
//

struct ProductModel {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Double
    let currency: String
    let imageUrl: String

    init(
        id: Int,
        categoryId: Int,
        title: String,
        description: String,
        price: Double,
        currency: String,
        imageUrl: String
    ) {
        self.id = id
        self.categoryId = categoryId
        self.title = title
        self.description = description
        self.price = price
        self.currency = currency
        self.imageUrl = imageUrl
    }

    init(_ response: ProductResponseModel) {
        self.id = response.id
        self.categoryId = response.categoryId
        self.title = response.title
        self.description = response.description
        self.price = response.price
        self.currency = response.currency
        self.imageUrl = response.imageUrl
    }
}
