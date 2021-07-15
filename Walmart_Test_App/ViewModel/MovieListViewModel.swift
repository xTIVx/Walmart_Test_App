//
//  MovieListViewModel.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation


class MovieListViewModel {

    private var movieList: [Movie]?

    func getMoviesCount() -> Int {
        return movieList?.count ?? 0
    }
}
