//
//  DetailsScreenBuilder.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.

import Foundation
import UIKit

struct DetailsScreenBuilder: DetailsScreenBuilderProtocol {

    static func buildDetailsScreenModule(movie: Movie) -> DetailViewController {
        let router = DetailsScreenRouter()
        let interactor = DetailsScreenInteractor(router: router, movieId: movie.imdbId)
        let presenter = DetailsScreenPresenter(interactor: interactor)

        let viewController: DetailViewController = CommonHelper.makeViewController(
            identifier: "DetailViewController"
        )
        viewController.presenter = presenter
        viewController.configure(movie: movie)
        router.viewController = viewController

        return viewController
    }
}
