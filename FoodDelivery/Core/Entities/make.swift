//
//  make.swift
//  FoodDelivery
//
//  Created by Swift Learning on 18.10.2022.
//

public func make<T>(
    _ object: T,
    using closure: (inout T) -> Void
) -> T {
    var object = object
    closure(&object)
    return object
}
