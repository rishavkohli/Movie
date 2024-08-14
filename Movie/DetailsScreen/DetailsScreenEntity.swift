//
//  DetailsScreenEntity.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.


import Foundation

struct DetailItem {
    var heading: String
    var text: String
}

class MovieDetail: Codable {

    var title: String
    var year: String?
    var rated: String?
    var released: String?
    var runtime: String?
    var genre: String?
    var director: String?
    var writer: String?
    var actors: String?
    var plot: String?
    var language: String?
    var country: String?
    var awards: String?
    var metascore: String?
    var imdbRating: String?
    var dvd: String?
    var boxOffice: String?
    var production: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
    }

    init(title: String, year: String? = nil, rated: String? = nil, released: String? = nil, runtime: String? = nil, genre: String? = nil, director: String? = nil, writer: String? = nil, actors: String? = nil, plot: String? = nil, language: String? = nil, country: String? = nil, awards: String? = nil, metascore: String? = nil, imdbRating: String? = nil, dvd: String? = nil, boxOffice: String? = nil, production: String? = nil) {
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.metascore = metascore
        self.imdbRating = imdbRating
        self.dvd = dvd
        self.boxOffice = boxOffice
        self.production = production
    }

}
