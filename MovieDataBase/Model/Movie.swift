//
//  Movie.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 19/07/22.
//

import Foundation
struct Movies:Codable{
    let movies : [Movie]
}

// MARK: - Movie Struct used to structure the data from API
struct Movie: Codable{
    let title: String?
    let year: String?
    let rated: String?
    let released: String?
    let runtime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language:String?
    let awards: String?
    let country: String?
    let poster: String
    let ratings: [Rating]
    let metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let type: String?
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        
    }
    
    
    func getValuesForType(_ type: MovieEnum) -> [String]?{
        switch type {
        case .Year:
            return filterYearData(year ?? "")
        case .Genre:
            return filterOtherDataExceptYear(genre ?? "")
        case .Directors:
            return filterOtherDataExceptYear(director ?? "")
        case .Actors:
            return filterOtherDataExceptYear(actors ?? "")
        }
    }
    
    func getMoviesForType(_ type: MovieEnum, _ subCategory: String) -> Bool{
        
        switch type {
        case .Year:
            return year?.contains(subCategory) ?? false
        case .Genre:
            return genre?.contains(subCategory) ?? false
        case .Directors:
            return director?.contains(subCategory) ?? false
        case .Actors:
            return actors?.contains(subCategory) ?? false
        }
    }
    
    func getMovieForSearch(_ searchText: String) -> Bool{
        return (
            trimAndLowercases(genre ?? "").contains(searchText) ||
            trimAndLowercases(actors ?? "").contains(searchText) ||
            trimAndLowercases(director ?? "").contains(searchText) ||
            trimAndLowercases(title ?? "").contains(searchText))
    }
    
    private func filterYearData(_ normalText: String) -> [String]{
        let year =  normalText.split(separator: "–").map { String($0.trimmingCharacters(in: .punctuationCharacters))}
        print(year)
        return year
    }
    
    private func filterOtherDataExceptYear(_ normalText:String) ->[String] {
        let filterdData = normalText.split(separator: ",").map { String($0.trimmingCharacters(in: .punctuationCharacters) ) }
        return filterdData
    }
    
    private func trimAndLowercases(_ unfilterdText: String) -> String{
        return unfilterdText.replacingOccurrences(of: " ", with: "").lowercased()
    }
    
}
// MARK: - Rating
struct Rating: Codable {
    let source, value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

struct Cell{
    static let MovieListCell = "MovieListCell"
    static let MovieDetailCell = "MovieDetailCell"
    static let MovieCategoriesViewCell = "MovieCategoriesViewCell"
}



