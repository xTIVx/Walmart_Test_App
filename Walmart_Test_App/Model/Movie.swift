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


struct Movie: Codable {
    let title: String?
    let popularity: Double?
    let release_date: String?
    let poster_path: String?
    let genre_ids: [Int]?
    let mainGenre: Genre?
}
