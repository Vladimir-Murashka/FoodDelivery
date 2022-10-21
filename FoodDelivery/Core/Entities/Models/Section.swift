//
//  Section.swift
//  FoodDelivery
//
//  Created by Swift Learning on 19.10.2022.
//

import CoreFoundation

struct Section {
    let type: SectionType
    let rows: [RowType]
}

enum SectionType {
    case promotions
    case products(CategoriesHeaderViewModel)
}

enum RowType {
    case promotions(PromotionsTableViewCellViewModel)
    case product(ProductCellViewModel)
}
