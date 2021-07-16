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

    // Need for return updated Movie object back to Controller
    var delegate: UpdateDetailProtocol?

    // Object for show on DetailVC, comes from MovieListVC
    var movieObject: Movie? {
        didSet {
            guard let movie = movieObject else {return}
            delegate?.didRecieveMovie(movie: movie)
        }
    }


    /// Func getting existing Movie object and adding missing fields for DetailVC
    /// - Parameters:
    ///   - movie: Existing object
    ///   - completion: calling with updated Movie
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


    /// Need for initially set object to VM
    /// - Parameter movie: came from MovieList
    func setMovieObject(movie: Movie) {
        self.updateMovieObject(movie: movie) { movie in
            self.movieObject = movie
        }
    }

    /// Using for download image poster for UIImage
    /// - Returns: Data with image
    func getPoster() -> Data? {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(self.movieObject?.poster_path ?? "")") {
            if let data = try? Data(contentsOf: url) {
                return data
            }
        }
        return nil
    }
}
