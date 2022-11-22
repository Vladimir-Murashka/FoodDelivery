//
//  CategoriesHeaderViewModel.swift
//  FoodDelivery
//
//  Created by Swift Learning on 21.10.2022.
//

protocol CategoriesHeaderViewModelDelegate: AnyObject {
    func didTapCategory(at index: Int)
}

struct CategoriesHeaderViewModel {
    let categories: [CategoryCellViewModel]
    weak var delegate: CategoriesHeaderViewModelDelegate?
}
