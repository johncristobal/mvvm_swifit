//
//  Constants.swift
//  MvvmRxMovieApp
//
//  Created by MACBOOK on 03/02/21.
//

import Foundation

struct Constants{
    static let apikey = "?api_key=2088defd3f0ba24a48234d3d5b7fdfa0"
    
    struct Url {
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
 
    struct Endpoints {
        static let urlListPopularMovies = "3/movie/popular"
        static let urlDetailMovie = "3/movie"
    }
}
