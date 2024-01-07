//
//  APIHandlers.swift
//  Shopping App
//
//  Created by Avinash Kumar on 07/01/24.
//

import Foundation

protocol ProductDetailsDelegate {
    func fetchProductDetails(id: Int, completionHandler: @escaping(Result<Product, DemoError>) -> Void)
}

protocol ProductListingDelegate {
    func fetchProducts(product: String?, completionHandler: @escaping(Result<ProductResponse, DemoError>) -> Void)
}


class ProductsService: ProductDetailsDelegate, ProductListingDelegate {
    func fetchProductDetails(id: Int, completionHandler: @escaping (Result<Product, DemoError>) -> Void) {
        guard let url = URL(string: APIs.productDetailsURL + "\(id)") else {
            completionHandler(.failure(.BadURL))
            return
        }
        NetworkManager().fetchRequest(type: Product.self, url: url) { results in
            switch results {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchProducts(product: String? = nil, completionHandler: @escaping (Result<ProductResponse, DemoError>) -> Void) {
        let urlString = getURL(product: product)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.BadURL))
            return
        }
        NetworkManager().fetchRequest(type: ProductResponse.self, url: url, completion: completionHandler)
        
    }
    
    func getURL(product: String? = nil) -> String {
        var urlToPick: String
        if product != nil {
            guard let product = product else { return "" }
            urlToPick = APIs.searchProductURL + "?q=\(product)"
        } else {
            urlToPick = APIs.url
        }
        return urlToPick
    }
}
