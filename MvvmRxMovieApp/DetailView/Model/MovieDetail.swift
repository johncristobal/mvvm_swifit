//
//  MovieDetail.swift
//  MvvmRxMovieApp
//
//  Created by John Alexis Cristobal Jimenez  on 05/02/21.
//

import Foundation
struct MovieDetail : Codable{
    
    let title: String
    let backdropPath: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let originalTitle: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
