//
//  EndPoints.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation



struct EndPoint {
    let scheme: String
    let host: String
    let path: String
    let query: [URLQueryItem]
}

enum EndPoints {
    case popularMovies
    case genres
}

let endPointList: [EndPoints: EndPoint] = [
    .popularMovies: EndPoint(scheme: "https", host: "api.themoviedb.org", path: "/3/movie/popular", query: [
        URLQueryItem(name: "api_key", value: Constants.APIKey.rawValue),
        URLQueryItem(name: "language", value: "en-US"),
    ]),
    .genres: EndPoint(scheme: "https", host: "api.themoviedb.org", path: "/3/genre/movie/list", query: [
        URLQueryItem(name: "api_key", value: Constants.APIKey.rawValue),
        URLQueryItem(name: "language", value: "en-US")
    ])
]
