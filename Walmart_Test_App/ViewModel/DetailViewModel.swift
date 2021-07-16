//
//  DetailViewModel.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation

protocol UpdateDetailProtocol {
    func didRecieveMovie(movie: Movie)
}

class DetailViewModel {

    var delegate: UpdateDetailProtocol?

    var movieObject: Movie? {
        didSet {
            guard let movie = movieObject else {return}
            delegate?.didRecieveMovie(movie: movie)
        }
    }

    func updateMovieObject(movie: Movie, completion:@escaping (Movie) -> ()) {
        guard let id = movie.id else {return}
        APIHandler.shared.requestData(endPoint: .movieDetails, movieID: id) { resp in
            guard let resp = (resp as? Movie) else {return}
            var updatedMovie = movie
            updatedMovie.homepage = resp.homepage
            updatedMovie.overview = resp.overview
            updatedMovie.runtime = resp.runtime
            completion(updatedMovie)
        }
    }

    func setMovieObject(movie: Movie) {
        self.updateMovieObject(movie: movie) { movie in
            self.movieObject = movie
        }
    }

    func getPoster() -> Data? {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(self.movieObject?.poster_path ?? "")") {
            if let data = try? Data(contentsOf: url) {
                return data
            }
        }
        return nil
    }
}
