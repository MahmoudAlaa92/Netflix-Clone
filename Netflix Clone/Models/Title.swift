//
//  Movie.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 17/06/2024.
//

import Foundation

struct TrendingTitles: Codable {
    let results:[Titles]
}

struct Titles: Codable{
    let id: Int
    let media_type: String?
    let original_title: String?
    let original_name: String?
    let vote_average: Double
    let vote_count: Int
    let release_date: String?
    let poster_path: String?
    let overview: String?
}

