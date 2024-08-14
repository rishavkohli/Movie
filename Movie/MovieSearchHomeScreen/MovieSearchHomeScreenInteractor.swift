//
//  MovieSearchHomeScreenInteractor.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.

import Foundation

final class MovieSearchHomeScreenInteractor {

    private let router: MovieSearchHomeScreenRouterProtocol
    private var searchText: String?
    private var pageNumber: Int = 1

    init(router: MovieSearchHomeScreenRouterProtocol) {
        self.router = router
    }

   // network call to get results
    private func getListData(completion: @escaping (MovieSearch?) -> ()) {
        if let searchText, let url = MovieServiceEndpoint.titleSearch(title: searchText, page: pageNumber).url {

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data , let decoded = try? JSONDecoder().decode(MovieSearch.self, from: data) {
                    completion(decoded)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}

extension MovieSearchHomeScreenInteractor: MovieSearchHomeScreenInteractorProtocol {

    func viewLoaded() {
       //Action to be taken by presenter once the view is loaded
    }

    // //to get movies for page 1
    func getListOfMovies(searchText: String?, completion: @escaping (MovieSearch?) -> ()) {
        if(self.searchText == searchText) {
            return
        }
        self.searchText = searchText
        pageNumber = 1
        getListData(completion: completion)
    }

    //to get movies for next page
    func getNextPageData(completion: @escaping (MovieSearch?) -> ()) {
        pageNumber = pageNumber + 1
        getListData(completion: completion)
    }
    
    // when user tap on any movie
    func movieTapped(movie: Movie) {
        self.router.openDetailsPage(movie: movie)
    }

}
