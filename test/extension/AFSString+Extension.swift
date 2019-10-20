//
//  AFSString+Extension.swift
//  test
//
//  Created by Lukáš Spurný on 17/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import Foundation

extension String {
    
    static func replaceHttpToHttps(with urlString: String) -> String? {
        // split into array
        let separateCriteria = "://"
        var parts = urlString.components(separatedBy: separateCriteria)
        // do checking and join
//        for (index, part) in parts.enumerated() {
//            print("\(index) : \(part)")
//        }
        parts[0] = "https"
        guard let firstpart = parts.first, let lastPart = parts.last else {
//            print("AFString+Extension: replaceHttpToHttps: failed")
            return nil
        }
        let finalString = firstpart + separateCriteria + lastPart
        return finalString
    }
    
    //MARK: - Check language localization
    static func localeSetting() -> String{
        var localeParameter:String = ""
        if let locale = Locale.current.languageCode {
            localeParameter += locale
        }else{
            localeParameter += "en"
        }
        //CUSTOM !!!
        localeParameter = "cs"
        return localeParameter
    }
    
}
