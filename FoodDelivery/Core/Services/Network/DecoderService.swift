//
//  DecoderService.swift
//  FoodDelivery
//
//  Created by Swift Learning on 25.10.2022.
//

import Foundation

protocol Decoderable {
    func decode<T: Decodable>(
        from data: Data,
        completion: @escaping (
            Result<T,
            Error>
        ) -> Void)
}

final class DecoderService {}

extension DecoderService: Decoderable {
    func decode<T: Decodable>(
        from data: Data,
        completion: @escaping (
            Result<T,
            Error>
        ) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let result = try JSONDecoder().decode(
                    T.self,
                    from: data
                )
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
