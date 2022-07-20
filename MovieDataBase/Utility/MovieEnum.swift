//
//  MovieEnum.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 19/07/22.
//

import Foundation
enum MovieEnum: String,CaseIterable{
    case Year
    case Genre
    case Directors
    case Actors
    
  static func getType(_ index: Int) -> String{
        let types = MovieEnum.allCases.map { $0.rawValue }
        return types[index]
    }
}

enum RatingType: String{
  case Internet = "Internet Movie Database"
  case Rotten = "Rotten Tomatoes"
  case Metacritic = "Metacritic"
}


enum CellType: String{
  case cell
  case MovieListCell
  case MovieCategoriesViewCell
}

