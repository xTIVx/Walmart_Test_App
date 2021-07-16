//
//  APIHandler.swift
//  Walmart_Test_App
//
//  Created by Igor Chernobai on 7/15/21.
//

import Foundation

class APIHandler {

    // Singleton
    static let shared = APIHandler()
    private init() {}

    /// Universal func for build URL using Endpoints
    /// - Parameters:
    ///   - endPoint: enum with all avaliable options for build URL
    ///   - page: page number, can be used if building URL for fetch list of popular movies, need for download next page with movies (paginagion)
    ///   - movieID: optionally using for build URL for specific movie details (for DetailsVC)
    /// - Returns: Ready to request URL
    private func createURL(endPoint: EndPoints, page: Int? = nil, movieID: Int? = nil) -> URL? {
        guard let component = endPointList[endPoint] else { return nil }
        var components = URLComponents()
        components.scheme = component.scheme
        components.host = component.host
        components.queryItems = component.query
        page != nil ? components.queryItems?.append(URLQueryItem(name: "page", value: String(page!))) : nil
        if movieID != nil {
            components.path = "\(component.path)/\(movieID!.description)"
        } else {
            components.path = component.path
        }
        guard let url = components.url else {
            print("Error: cannot create URL")
            return nil
        }
        return url
    }

    /// Universal func for make request and parse response
    /// - Parameters:
    ///   - endPoint: check "createURL()" documentation, same thing
    ///   - page: check "createURL()" documentation, same thing
    ///   - movieID: check "createURL()" documentation, same thing
    ///   - completion: Getting one from Models (Genres or Movies)
    func requestData(endPoint: EndPoints, page: Int? = nil, movieID: Int? = nil, completion: @escaping (Returnable?) -> ()) {
        
        guard let url = createURL(endPoint: endPoint, page: page, movieID: movieID) else { return }
        URLSession.shared.dataTask(with: url) { data, _, err in
            guard data != nil,
                  err == nil else { print(err?.localizedDescription ?? ""); return }

            completion(self.decodeData(endPoint: endPoint, data: data!)
            )}.resume()
    }


    /// Universal data decoder depends on EndPoints cases
    /// - Parameters:
    ///   - endPoint: Depends on this parameter, parsing to different Model
    ///   - data: Data from URL request
    /// - Returns: One from Models depends on end point
    private func decodeData(endPoint: EndPoints, data: Data) -> Returnable? {
        var response: Returnable?
        do {
            let decoder = JSONDecoder()
            switch endPoint {
            case .popularMovies:
                response = try decoder.decode(Movies.self, from: data)
                break
            case .genres:
                response = try decoder.decode(Genres.self, from: data)
                break
            case .movieDetails:
                response = try decoder.decode(Movie.self, from: data)
                break
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return response
    }
}
