//
//  PromotionModel.swift
//  FoodDelivery
//
//  Created by Swift Learning on 24.10.2022.
//

struct PromotionModel {
    let id: Int
    let imageUrl: String

    init(id: Int, imageUrl: String) {
        self.id = id
        self.imageUrl = imageUrl
    }

    init(_ response: PromotionResponseModel) {
        id = response.id
        imageUrl = response.imageUrl
    }
}
