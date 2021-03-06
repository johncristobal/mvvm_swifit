//
//  Movies.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page: Int
    let results: [Result]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Result: Codable {
    let title, backdropPath: String
    let popularity: Double
    let id: Int
    let voteCount: Int
    let voteAverage: Double
    let overview, releaseDate: String
    let posterPath: String
    let adult: Bool
    let genreIDS: [Int]
    let originalTitle: String
    let originalLanguage: OriginalLanguage
    let video: Bool
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case ko = "ko"
    case zh = "zh"
}
