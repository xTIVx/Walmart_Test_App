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
    var currentPage = 1


    /// Func for update list of genres
    /// - Parameter completion: Calling completion when genres are updated
    private func fetchGenres(completion:@escaping () -> ()) {
        APIHandler.shared.requestData(endPoint: .genres) { [weak self] resp in
            guard let genres = (resp as? Genres)?.genres,
                  let self = self else {return}
            self.genres = genres
            completion()
        }
    }

    /// Func for update list of Movies
    /// - Parameters:
    ///   - page: number of page (1 page containing 20 movie objects)
    ///   - completion: calling when update is done
    private func fetchMovies(page: Int = 1, completion:@escaping () -> ()) {
        APIHandler.shared.requestData(endPoint: .popularMovies, page: page) { [weak self] resp in
            guard let movies = (resp as? Movies)?.results,
                  let self = self else {return}
            self.movieList == nil ? self.movieList = movies : self.movieList?.append(contentsOf: movies)
            completion()
        }
    }

    /// Function combiner, fetching genres and movies 1 by 1
    /// - Parameter completion: calling when function is done with update genres and movies
    func fetchMovieData(completion:@escaping () -> ()) {
        let dg = DispatchGroup()
        if genres == nil {
            dg.enter()
            fetchGenres {
                dg.leave()
            }
        }
        dg.enter()
        fetchMovies(page: self.currentPage) {
            self.currentPage += 1
            dg.leave()
        }

        dg.notify(queue: .global(), work: DispatchWorkItem(block: {
            completion()
        }))
    }


    /// Func for an access to Movie for specific item in collectionView
    /// - Parameter item: number for item(row) in collecion view
    /// - Returns: Movie object for specific item
    func getMovieForCell(at item: Int) -> Movie? {
        guard let movie = movieList?[item],
              let genreID = movie.genre_ids?.first else {return nil}
        let genre = genres?.filter {$0.id == genreID}
        
        return Movie(title: movie.title, popularity: movie.popularity, release_date: movie.release_date, poster_path: movie.poster_path, genre_ids: nil, mainGenre: genre?.first, id: movie.id)
    }


    /// - Returns: Count of items for CollectionView depends of number of Movie objects
    func getMoviesCount() -> Int {
        return movieList?.count ?? 0
    }
}
