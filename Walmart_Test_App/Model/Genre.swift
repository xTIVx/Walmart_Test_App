//
//  Genre.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation


struct Genres: Codable {
    let genres: [Genre]
}


struct Genre: Codable {
    let id: Int?
    let name: String?
}

