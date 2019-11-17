//
//  Results.swift
//  test
//
//  Created by Lukáš Spurný on 17/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import Foundation
import Alamofire

struct Results: Codable {
    let popularity:Double?
    let vote_count:Int?
    let video:Bool?
    let poster_path: String?
    let id:Int?
    let adult:Bool?
    var backdrop_path:String?
    let original_language:String?
    let original_title:String?
    let genre_ids:[Int]?
    let title:String?
    let vote_average:Float?
    let overview: String?
    let release_date:String?
    
    init(results:Results){
        self.popularity = results.popularity
        self.vote_count = results.vote_count
        self.video = results.video
        self.poster_path = results.poster_path
        self.id = results.id
        self.adult = results.adult
        self.backdrop_path = results.backdrop_path
        self.original_language = results.original_language
        self.original_title = results.original_title
        self.genre_ids = results.genre_ids
        self.title = results.title
        self.vote_average = results.vote_average
        self.overview = results.overview
        self.release_date = results.release_date
    }
    
    init?(json: [String:Any]){
        if let popularity = json["popularity"],
            let vote_count = json["vote_count"],
            let video = json["video"],
            let poster_path = json["poster_path"],
            let id = json["id"],
            let adult = json["adult"],
            let backdrop_path = json["backdrop_path"],
            let original_language = json["original_language"],
            let original_title = json["original_title"],
            let genre_ids = json["genre_ids"],
            let title = json["title"],
            let vote_average = json["vote_average"],
            let overview = json["overview"],
            let release_date = json["adult"]{

            self.popularity = popularity as? Double
            self.vote_count = vote_count as? Int
            self.video = video as? Bool
            self.poster_path = poster_path as? String
            self.id = id as? Int
            self.adult = adult as? Bool
            self.backdrop_path = backdrop_path as? String
            self.original_language = original_language as? String
            self.original_title = original_title as? String
            self.genre_ids = genre_ids as? [Int]
            self.title = title as? String
            self.vote_average = vote_average as? Float
            self.overview = overview as? String
            self.release_date = release_date as? String
        }else{
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case vote_count = "vote_count"
        case video = "video"
        case poster_path = "poster_path"
        case id = "id"
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case original_language = "original_language"
        case original_title = "original_title"
        case genre_ids = "genre_ids"
        case title = "title"
        case vote_average = "vote_average"
        case overview = "overview"
        case release_date = "release_date"
    }
    
}
