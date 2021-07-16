//
//  Movie.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation

protocol Returnable {}

struct Movies: Codable, Returnable {
    let results: [Movie]
}


struct Movie: Codable, Returnable {
    let title: String?
    let popularity: Double?
    let release_date: String?
    let poster_path: String?
    let genre_ids: [Int]?
    let mainGenre: Genre?
    let id: Int?
    var overview: String? = nil
    var runtime: Int? = nil
    var homepage: String? = nil
}

// https://api.themoviedb.org/3/movie/52125?api_key=d1c25a3c5f26b3b44061523d7ae96cd6
