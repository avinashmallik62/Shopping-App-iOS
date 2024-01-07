//
//  ProductListingViewModelTests.swift
//  ProductListingViewModel Tests
//
//  Created by Avinash Kumar on 07/01/24.
//

import XCTest
@testable import Shopping_App

final class ProductListingViewModelTests: XCTestCase {

    var productListingViewModel: ProductListingViewModel!
    override func setUpWithError() throws {
        productListingViewModel = ProductListingViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchProducts() {
        productListingViewModel.fetchProducts { products in
            XCTAssertNotNil(products)
        }
    }
    
    func testFetchSearchedProduct() {
        productListingViewModel.fetchSearchedProducts(product: "iphone") { products in
            XCTAssertNotNil(products)
        }
    }

}
