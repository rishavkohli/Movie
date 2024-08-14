//
//  DetailsScreenPresenter.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.


import Foundation

final class DetailsScreenPresenter {

    private var details = [DetailItem]()

    private let interactor: DetailsScreenInteractorProtocol

    init(interactor: DetailsScreenInteractorProtocol) {
        self.interactor = interactor
    }

    // helper function for data transformation
    private func add(_ string: String?, heading: String) {
        guard let string = string, !string.isEmpty else {
            return
        }
        details.append(DetailItem(heading: heading, text: string))
    }
}

extension DetailsScreenPresenter: DetailsScreenPresenterProtocol {

    func viewLoaded() {
       //Action to be taken by presenter once the view is loaded
       interactor.viewLoaded()
    }

    // to get details and convert it to ui presentable form
    func getDetails(completion: @escaping (Bool?) -> ()) {
        self.interactor.getDetails { [weak self] movieDetail in
            if let movieDetail {

                self?.add(movieDetail.director, heading: "Director")
                self?.add(movieDetail.genre, heading: "Genre")
                self?.add(movieDetail.plot, heading: "Plot")
                self?.add(movieDetail.released, heading: "Release Date")
                self?.add(movieDetail.country, heading: "Country")
                self?.add(movieDetail.rated, heading: "Rated")
                self?.add(movieDetail.actors, heading: "Actors")
                self?.add(movieDetail.writer, heading: "Writer")
                self?.add(movieDetail.awards, heading: "Awards")
                self?.add(movieDetail.boxOffice, heading: "Box Office Takings")
                self?.add(movieDetail.metascore, heading: "Metascore")
                self?.add(movieDetail.imdbRating, heading: "IMDB Rating")
                self?.add(movieDetail.dvd, heading: "DVD Release Date")
                self?.add(movieDetail.production, heading: "Production")

                completion(true)
            } else {
                completion(false)
            }
        }
    }

    // to get table view cell data
    func getDataForIndex(index: Int) -> DetailItem {
        self.details[index]
    }

    // to get number of cell for details
    func getNumberOfRows() -> Int {
        return self.details.count
    }
}
