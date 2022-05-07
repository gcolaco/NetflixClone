//
//  TVShow.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 07/05/22.
//

import Foundation

struct TrendingTVShow: Decodable {
    let results: [TVShow]
}

struct TVShow: Decodable {
    let id: Int
    let mediaType: String?
    let originalLanguage: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int
    let voteAverage: Double
    let releaseDate: String?
}
