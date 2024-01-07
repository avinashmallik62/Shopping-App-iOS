//
//  ProductListingViewModel.swift
//  NoBrokerAssignment
//
//  Created by Avinash Kumar on 05/01/24.
//

import Foundation

class ProductListingViewModel {
    func fetchProducts(completionHandler: @escaping (Result<ProductResponse, DemoError>) -> ()) {
        ProductsService().fetchProducts { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchSearchedProducts(product: String, completionHandler: @escaping (Result<ProductResponse, DemoError>) -> ()) {
        ProductsService().fetchProducts(product: product) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
