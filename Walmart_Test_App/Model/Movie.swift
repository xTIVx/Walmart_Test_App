//
//  Movie.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation



struct Movie: Codable {
    let title: String?
    let popularity: Double?
    let release_date: String?
    let poster_path: String?
    let genre_ids: [Int]?
}
