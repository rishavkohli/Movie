//
//  MovieSearchHomeScreenEntity.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.

import Foundation

// MARK: - Movie

class Movie: Codable {

    let title: String
    let year: String?
    let imdbId: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

    init(title: String, year: String?, imdbId: String?, type: String?, poster: String?) {
        self.title = title
        self.year = year
        self.imdbId = imdbId
        self.type = type
        self.poster = poster
    }

}

class MovieSearch: Decodable {
    let search: [Movie]?
    private let totalResultsString: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResultsString = "totalResults"
    }

    var totalResults: Int? {
        guard let str = totalResultsString else {
            return nil
        }

        return Int(str)
    }
}





