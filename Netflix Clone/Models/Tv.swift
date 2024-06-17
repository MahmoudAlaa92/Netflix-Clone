//
//  Tv.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 18/06/2024.
//

import Foundation
struct TrendingTv:Codable {
    let reults: [Tv]
}

struct Tv: Codable{
    let id: Int
    let media_type: String?
    let original_title: String?
    let vote_average: Double
    let vote_count: Int
    let release_date: String?
    let poster_path: String?
    let overview: String?
}
