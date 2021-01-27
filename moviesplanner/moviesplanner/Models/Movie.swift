//
//  Movie.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 14/01/2021.
//

import Foundation


// MARK: - Movies
class Movies: Codable {
    let searchType, expression: String
    let results: [Movie]
    let errorMessage: String

    init(searchType: String, expression: String, results: [Movie], errorMessage: String) {
        self.searchType = searchType
        self.expression = expression
        self.results = results
        self.errorMessage = errorMessage
    }
}

// MARK: - Result
class Movie: Codable {
    let id, resultType: String
    let image: String
    let title, resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }

    init(id: String, resultType: String, image: String, title: String, resultDescription: String) {
        self.id = id
        self.resultType = resultType
        self.image = image
        self.title = title
        self.resultDescription = resultDescription
    }
}
