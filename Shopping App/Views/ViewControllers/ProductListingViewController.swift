//
//  ProductListingViewController.swift
//  NoBrokerAssignment
//
//  Created by Avinash Kumar on 05/01/24.
//

import UIKit

class ProductListingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let productListingViewModel = ProductListingViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var searching: Bool = false
    var productList: [Product] = []
    var searchProductList: [Product] = []
    var searchTimer: Timer?
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.stopAnimating()
    }
    
    func setup() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        productListingViewModel.fetchProducts { result in
            switch result {
            case .success(let products):
           
                self.productList = products.products
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        configureSearchController()
    }
    
    
    func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search a product"
    }
}


extension ProductListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searchProductList.count
        } else {
            return productList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if searching {
            if let url = URL(string: searchProductList[indexPath.row].images.last ?? "") {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell.productImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            cell.productName.text = searchProductList[indexPath.row].title
        } else {
            if let url = URL(string: productList[indexPath.row].images.last ?? "") {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell.productImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            cell.productName.text = productList[indexPath.row].title
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 200, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = mainStoryBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        destinationVC.id = !searchProductList.isEmpty ? searchProductList[indexPath.row].id : productList[indexPath.row].id
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchTimer?.invalidate()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            self.performSearch(with: searchText)
        }
    }

    func performSearch(with searchText: String) {
        if !searchText.isEmpty {
            searchProductList.removeAll()
            searching = true
            
            productListingViewModel.fetchSearchedProducts(product: searchText.lowercased()) { [weak self] result in
                switch result {
                case .success(let productList):
                    self?.searchProductList = productList.products
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            searching = false
            searchProductList.removeAll()
            searchProductList = productList
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchProductList.removeAll()
        collectionView.reloadData()
    }
}
