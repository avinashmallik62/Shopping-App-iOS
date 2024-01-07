//
//  ProductDetailsViewController.swift
//  NoBrokerAssignment
//
//  Created by Avinash Kumar on 06/01/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var userRating: UILabel!
    
    var id: Int = 0
    var productDetailsVM = ProductDetailsViewModel()
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetailsVM.fetchProduct(id: id) { [weak self] result in
            switch result {
            case .success(let product):
                self?.product = product
                guard let imageURL = self?.product?.images.first,
                      let url = URL(string: imageURL),
                      let data = try? Data(contentsOf: url),
                      let price = product?.price,
                      let rating = product?.rating else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.userRating.text = "User Rating: \(rating)"
                    self?.productPrice.text = "$ \(price)"
                    self?.productTitle.text = product?.title
                    self?.productDescription.text = product?.description
                    self?.productImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
