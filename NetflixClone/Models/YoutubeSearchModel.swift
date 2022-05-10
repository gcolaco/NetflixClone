//
//  YoutubeSearchModel.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 10/05/22.
//

import Foundation

struct YoutubeSearchModel: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
