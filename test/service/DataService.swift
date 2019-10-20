//
//  DataService.swift
//  test
//
//  Created by Lukáš Spurný on 17/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import Foundation
import Alamofire

struct DataService {
    
    // MARK: - Singleton
    static let shared = DataService()
    
    private let api_key:String = "?api_key=bae5ff7bac4feec8604266fabb028a17"
    private let address:String = "https://api.themoviedb.org/3/"
    
    // MARK: - Services
    func requestFetchData(parameter: String?,pageParameter: Int?, localeParameter: String?, completion: @escaping (Catalog?, Error?) -> ()) {

        var customUrl = self.address
        if let customParameter = parameter{
            customUrl += customParameter
        }
        customUrl += self.api_key
        if let customPageParameter = pageParameter{
            customUrl += "&page=\(customPageParameter)"
        }
        if let customLocaleParameter = localeParameter{
            customUrl += "&language=\(customLocaleParameter)" 
        }
   
        guard let formattedUrlString = String.replaceHttpToHttps(with: customUrl), let url = URL(string: formattedUrlString) else {
            return
        }
        
        Alamofire.request(url, method:.get).responseCatalog { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let catalog = response.result.value {
                completion(catalog, nil)
                return
            }
        }
    }
    
}
