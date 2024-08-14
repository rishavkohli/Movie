//
//  MovieSearchHomeScreenBuilder.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.

import Foundation
import UIKit

struct MovieSearchHomeScreenBuilder: MovieSearchHomeScreenBuilderProtocol {

    static func buildMovieSearchHomeScreenModule() -> MovieSearchHomeScreenViewController {
        let router = MovieSearchHomeScreenRouter()
        let interactor = MovieSearchHomeScreenInteractor(router: router)
        let presenter = MovieSearchHomeScreenPresenter(interactor: interactor)

        let viewController = MovieSearchHomeScreenViewController(presenter: presenter)
        router.viewController = viewController

        return viewController
    }
}
