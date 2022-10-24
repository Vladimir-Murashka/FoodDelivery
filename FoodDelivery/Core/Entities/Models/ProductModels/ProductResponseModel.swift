//
//  ProductResponseModel.swift
//  FoodDelivery
//
//  Created by Swift Learning on 24.10.2022.
//

struct ProductResponseModel: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let currency: String
    let imageUrl: String
}
