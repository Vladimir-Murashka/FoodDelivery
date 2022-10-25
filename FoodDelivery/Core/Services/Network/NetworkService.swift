//
//  NetworkService.swift
//  FoodDelivery
//
//  Created by Swift Learning on 25.10.2022.
//

import Foundation

protocol Networkable {
    func request<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, Error>
        ) -> Void)
}

final class NetworkService {
    private let decoderService: Decoderable
    
    init(decoderService: Decoderable) {
        self.decoderService = decoderService
    }
}

extension NetworkService: Networkable {
    func request<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, Error>
        ) -> Void) {
        func completionHandler(result: Result<T, Error>) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        guard let url = URL(string: urlString) else {
            // handle error
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            URLSession.shared.dataTask(with: url) {
                [weak self] data,
                urlResponse,
                error in
                if let error = error {
                    completionHandler(result: .failure(error))
                    return
                }
                
                guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                    // handle error
                    return
                }
                
                switch httpURLResponse.statusCode {
                case 200...299:
                    
                    guard let data = data else {
                        // handle error
                        return
                    }
                    
                    self?.decoderService.decode(from: data, completion: completion)
                    //case 401:
                    // refresh token
                default:
                    // handle error
                    return
                }
            }
            .resume()
        }
    }
}
