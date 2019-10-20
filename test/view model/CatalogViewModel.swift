//
//  CatalogViewModel.swift
//  test
//
//  Created by Lukáš Spurný on 17/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit

class CatalogViewModel {
    
    // MARK: - Properties
    private var catalog: Catalog? {
        didSet {
            guard let c = catalog else { return }
            self.setupText(with: c)
//            self.fetchImage(results: c.results)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [Results]?
    
    private var dataService: DataService?
    var imageService: ImageService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService, imageService: ImageService) {
        self.dataService = dataService
        self.imageService = imageService
    }
    
    // MARK: - Network call
    func fetchCatalog(parameter: String,pageParameter: Int, localeParameter: String) {
        
        self.dataService?.requestFetchData(parameter: parameter,pageParameter: pageParameter, localeParameter: localeParameter, completion: { (catalog, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.catalog = catalog
        })
    }
    
    // MARK: - UI Logic
    private func setupText(with catalog: Catalog) {
        if let page = catalog.page, let total_results = catalog.total_results, let total_pages = catalog.total_pages, let results = catalog.results {
            self.page = page
            self.total_results = total_results
            self.total_pages = total_pages
            if page == 1{
                self.results = results
            }else{
                self.results?.append(contentsOf: results)
            }
        }
    }
    
}

