//
//  DetailsScreenProtocols.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.


import Foundation

protocol DetailsScreenBuilderProtocol {
    static func buildDetailsScreenModule(movie: Movie) -> DetailViewController
}

protocol DetailsScreenViewProtocol: AnyObject {

}

protocol DetailsScreenPresenterProtocol: AnyObject {
    func viewLoaded()
    func getDetails(completion: @escaping (Bool?) -> ())
    func getDataForIndex(index: Int) -> DetailItem
    func getNumberOfRows() -> Int
}

protocol DetailsScreenInteractorProtocol {
    func viewLoaded()
    func getDetails(completion: @escaping (MovieDetail?) -> ())
}

protocol DetailsScreenRouterProtocol: AnyObject {

}
