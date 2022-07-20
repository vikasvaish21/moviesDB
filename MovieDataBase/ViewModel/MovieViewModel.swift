//
//  MovieViewModel.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 19/07/22.
//

import Foundation
class MovieViewModel{
    
    var movies = [Movie]()
    var searchMovies = [Movie]()
    var categories = [String]()
    var orginalMovieData = [Movie]()
    var categoriesType: MovieEnum = .Genre
    var isFilteredMovies = false
    
    init(){
        getMovies()
    }
    
    func getMovies() {
        if let jsonData =  Bundle.main.url(forResource: "movies", withExtension: "json"){
            if let data = try? Data(contentsOf: jsonData){
                if let movies = try? JSONDecoder().decode([Movie].self, from: data){
                    self.movies = movies
                    self.orginalMovieData = movies
                }
            }
        }
    }
    
    func searchMoviesText(_ searchtext: String) -> [Movie] {
        searchMovies = orginalMovieData.filter{$0.getMovieForSearch(searchtext.lowercased())}
        return searchMovies
    }
    
    func filterMoviesCategories(_ type: MovieEnum) {
        categoriesType = type
        let filterData: [String] = movies.reduce([String]()){result,movie in
            result + (movie.getValuesForType(type) ?? [])
        }
        categories = Array(Set(filterData))
    }
    
    func getMoviesBySubCategories(_ type: MovieEnum,_ subCategories: String) -> [Movie] {
        return movies.filter({$0.getMoviesForType(type, subCategories)})
    }
    

}

