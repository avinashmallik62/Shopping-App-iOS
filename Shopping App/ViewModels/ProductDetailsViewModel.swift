//
//  ProductDetailsViewModel.swift
//  NoBrokerAssignment
//
//  Created by Avinash Kumar on 06/01/24.
//

import Foundation

class ProductDetailsViewModel {
    func fetchProduct(id: Int, completionHandler: @escaping (Result<Product?, DemoError>) -> ()) {
        ProductsService().fetchProductDetails(id: id) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

