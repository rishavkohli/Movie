//
//  MovieSearchHomeScreenRouter.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.

import Foundation
import UIKit

final class MovieSearchHomeScreenRouter: MovieSearchHomeScreenRouterProtocol {
    weak var viewController: MovieSearchHomeScreenViewController?

    // protocol function to open detail page
    func openDetailsPage(movie: Movie) {
        let vc = DetailsScreenBuilder.buildDetailsScreenModule(movie: movie)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.navigationController?.pushViewController( vc, animated: true )
        }
    }
}
