//
//  MovieListViewModel.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation


class MovieListViewModel {

    private var movieList: [Movie]?
    private var genres: [Genre]?

    private func fetchGenres(completion:@escaping () -> ()) {
        APIHandler.shared.requestData(endPoint: .genres) { [weak self] resp in
            guard let genres = (resp as? Genres)?.genres,
                  let self = self else {return}
            self.genres = genres
            completion()
        }
    }

    private func fetchMovies(page: Int = 1, completion:@escaping () -> ()) {
        APIHandler.shared.requestData(endPoint: .popularMovies, page: page) { [weak self] resp in
            guard let movies = (resp as? Movies)?.results,
                  let self = self else {return}
            self.movieList == nil ? self.movieList = movies : self.movieList?.append(contentsOf: movies)
            completion()
        }
    }

    func fetchMovieData(for page: Int = 1, completion:@escaping () -> ()) {
        let dg = DispatchGroup()

        dg.enter()
        fetchGenres {
            dg.leave()
        }
        dg.enter()
        fetchMovies(page: page) {
            dg.leave()
        }

        dg.notify(queue: .global(), work: DispatchWorkItem(block: {
            completion()
        }))
    }


    func getMoviesCount() -> Int {
        return movieList?.count ?? 0
    }
}
