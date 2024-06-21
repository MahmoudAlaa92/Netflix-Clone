//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Olajide Osho on 12/09/2022.
//

import Foundation

struct SearchListResponse: Codable {
    let items: [SearchResult]
   
}
struct SearchResult: Codable {
    let id: SearchResultID
}
struct SearchResultID: Codable {
    let kind: String?
    let videoId: String?
}

