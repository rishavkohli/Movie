//
//  DetailsScreenInteractor.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.

import Foundation

final class DetailsScreenInteractor: DetailsScreenInteractorProtocol {
    private let router: DetailsScreenRouterProtocol
    private let movieId: String?

    init(router: DetailsScreenRouterProtocol, movieId: String?) {
        self.router = router
        self.movieId = movieId
    }

    func viewLoaded() {
       //Action to be taken by presenter once the view is loaded
    }
    
    // api call to get details of a movie
    func getDetails(completion: @escaping (MovieDetail?) -> ()) {
        if let movieId, let url = MovieServiceEndpoint.getDetails(imbdId: movieId).url {

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data , let decoded = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                    completion(decoded)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
