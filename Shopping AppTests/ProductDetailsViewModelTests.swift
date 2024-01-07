//
//  ProductDetailsViewModelTests.swift
//  Shopping AppTests
//
//  Created by Avinash Kumar on 07/01/24.
//

import XCTest
@testable import Shopping_App

final class ProductDetailsViewModelTests: XCTestCase {

    var productDetailsViewModel: ProductDetailsViewModel!
    override func setUpWithError() throws {
        productDetailsViewModel = ProductDetailsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchProduct() {
        productDetailsViewModel.fetchProduct(id: 1) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data?.id, 1)
            case .failure(let failure):
                XCTAssertNil(failure)
            }
        }
    }

}
