//
//  Movie.swift
//  EndOfModTask
//
//  Created by Alistair Fraser on 2023-04-20.
//


import Blackbird
import Foundation

struct Movie: Identifiable, Codable, BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var t: String
    @BlackbirdColumn var y: String
    @BlackbirdColumn var plot: String
    @BlackbirdColumn var poster: String
    @BlackbirdColumn var runtime: String
    @BlackbirdColumn var IMDBRating: String
    @BlackbirdColumn var RottenTomatoes: String
    @BlackbirdColumn var MetacriticRating: String
    
}
let exampleMovie = Movie(id: 1, t: "Interstellar", y: "2014", plot: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.", poster: "https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg", runtime: "169 mins", IMDBRating: "8.6/10", RottenTomatoes: "72%", MetacriticRating: "74/100")
