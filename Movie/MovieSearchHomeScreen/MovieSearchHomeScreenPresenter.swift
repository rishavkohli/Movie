//
//  MovieSearchHomeScreenPresenter.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.

import Foundation

final class MovieSearchHomeScreenPresenter {

    private var moviesList: [Movie] = []
    private var totalNumberOfResults: Int = 0
    private let pageSize = 10
    private var networkCallInProgress = false

    private let interactor: MovieSearchHomeScreenInteractorProtocol

    init(interactor: MovieSearchHomeScreenInteractorProtocol) {
        self.interactor = interactor
    }

    // to check if next page exist
    private func hasNextPage() -> Bool{
        return self.moviesList.count < self.totalNumberOfResults ? true : false
    }

}

extension MovieSearchHomeScreenPresenter : MovieSearchHomeScreenPresenterProtocol {

    func viewLoaded() {
       //Action to be taken by presenter once the view is loaded
       interactor.viewLoaded()
    }

    // to get number of movies fetched
    func getNumberOfItems() -> Int {
        return self.moviesList.count
    }

    // to get data for a collection view cell
    func getDataForIndex(index: Int) -> Movie? {
        return self.moviesList[index]
    }

    //to get movies for page 1
    func getListOfMovies(searchText: String?, completion: @escaping (Bool?) -> ()) {
        self.interactor.getListOfMovies(searchText: searchText, completion: { [weak self] data in
            if let movieList = data?.search {
                self?.moviesList =  movieList
                self?.totalNumberOfResults = data?.totalResults ?? 0
                completion(true)
            } else {
                completion(false)
            }
        })

    }

    //to get movies for next page
    func getNextPageData(index: Int, completion: @escaping ([IndexPath]) -> ()) {
        if hasNextPage() && index > (self.moviesList.count - 4) && networkCallInProgress == false {
            networkCallInProgress = true
            self.interactor.getNextPageData(completion: { [weak self] data in

                let startIndex = self?.moviesList.count ?? 0
                let endIndex = startIndex + (data?.search?.count ?? 0)
                    let indexPaths = (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
                self?.moviesList.append( contentsOf: data?.search ?? [])
                self?.networkCallInProgress = false
                completion(indexPaths)
            })
        }
    }

    // when user tap on any movie
    func movieTapped(movie: Movie) {
        self.interactor.movieTapped(movie: movie)
    }

}
