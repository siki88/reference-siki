//
//  detailCatalogViewModel.swift
//  test
//
//  Created by Lukáš Spurný on 19/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit

class detailCatalogViewModel {
    
    // MARK: - Properties
    private var results: Results? {
        didSet {
            guard let _ = results else { return }
            self.didFinishFetch?()
        }
    }

    private var dataService: DataService?
    var imageService: ImageService?
    
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
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
    func fetchDetailCatalog(parameter: String, localeParameter: String) {
            
        self.dataService?.requestFetchData(parameter: parameter, pageParameter: nil, localeParameter: localeParameter, completion: { (catalog, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
        })
    }

}

