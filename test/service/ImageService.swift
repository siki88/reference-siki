//
//  ImageService.swift
//  test
//
//  Created by Lukáš Spurný on 19/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct ImageService {
    
    private let address:String = "https://image.tmdb.org/t/p/w342/"
    
    // MARK: - Services
    func requestFetchImage(image:String, completion: @escaping (UIImage?, Error?) -> ()) {
        var customAddress:String  = self.address
        customAddress += image
        
        guard let formattedUrlString = String.replaceHttpToHttps(with: customAddress), let url = URL(string: formattedUrlString) else {
            return
        }
        Alamofire.request(url).responseImage { response in
            if let error = response.error{
                completion(nil, error)
                return
            }
            if let image = response.result.value {
                completion(image, nil)
                return
            }
        }
    }

}
