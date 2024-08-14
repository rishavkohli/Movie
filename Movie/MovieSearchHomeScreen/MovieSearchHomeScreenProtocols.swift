//
//  MovieSearchHomeScreenProtocols.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.

import Foundation

protocol MovieSearchHomeScreenBuilderProtocol {
    static func buildMovieSearchHomeScreenModule() -> MovieSearchHomeScreenViewController
}

protocol MovieSearchHomeScreenViewProtocol: AnyObject {

}

protocol MovieSearchHomeScreenPresenterProtocol: AnyObject {
    func viewLoaded()
    func getListOfMovies(searchText: String?, completion: @escaping (Bool?) -> ())
    func getNextPageData(index: Int, completion: @escaping ([IndexPath]) -> ())
    func getNumberOfItems() -> Int
    func getDataForIndex(index: Int) -> Movie?
    func movieTapped(movie: Movie)
}

protocol MovieSearchHomeScreenInteractorProtocol {
    func viewLoaded()
    func getListOfMovies(searchText: String?, completion: @escaping (MovieSearch?) -> ())
    func getNextPageData(completion: @escaping (MovieSearch?) -> ())
    func movieTapped(movie: Movie)
}

protocol MovieSearchHomeScreenRouterProtocol: AnyObject {
    func openDetailsPage(movie: Movie)
}
