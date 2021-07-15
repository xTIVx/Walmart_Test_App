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

    private func createURL(endPoint: EndPoints, page: Int? = nil) -> URL? {
        guard let component = endPointList[endPoint] else { return nil }
        var components = URLComponents()
        components.scheme = component.scheme
        components.host = component.host
        components.path = component.path
        components.queryItems = component.query
        page != nil ? components.queryItems?.append(URLQueryItem(name: "page", value: String(page!))) : nil

        guard let url = components.url else {
            print("Error: cannot create URL")
            return nil
        }
        return url
    }

    func requestData(endPoint: EndPoints, page: Int? = nil, completion: @escaping (Returnable?) -> ()) {
        
        guard let url = createURL(endPoint: endPoint, page: page) else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            guard data != nil,
                  err == nil else { print(err?.localizedDescription ?? ""); return }

            completion(self.decodeData(endPoint: endPoint, data: data!)
            )}.resume()
    }

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
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return response
    }
    
}


//https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1

//https://api.themoviedb.org/3/genre/movie/list?api_key=<<api_key>>&language=en-US
