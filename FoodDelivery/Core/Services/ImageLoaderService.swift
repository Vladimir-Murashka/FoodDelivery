//
//  ImageLoaderService.swift
//  FoodDelivery
//
//  Created by Swift Learning on 25.10.2022.
//

import UIKit

protocol ImageLoaderable {}

final class ImageLoaderService {}

extension ImageLoaderService: ImageLoaderable {
    
    func loadImage(
        urlString: String,
        completion: @escaping (
            Result<UIImage,
            Error>
        ) -> Void) {
            DispatchQueue.global(qos: .utility).async {
                guard let url = URL(string: urlString) else {
                    //completion(.failure())
                    return
                }
                
                do {
                    let data = try Data(contentsOf: url)
                    guard let image = UIImage(data: data) else {
                        //completion(.failure())
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } catch {
                    //completion(.failure())
                    return
                }
            }
        }
}

extension UIImageView {
    func setImage(urlString: String) {
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: urlString) else {
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } catch {
                return
            }
        }
    }
}

