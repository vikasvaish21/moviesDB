//
//  MovieCategoriesViewController.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 19/07/22.
//

import Foundation
import UIKit
class MovieCategoriesViewController: UIViewController {
    
    var categoriesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    weak var movieViewModel: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        categoriesTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieViewModel.isFilteredMovies = false
        movieViewModel.movies = movieViewModel.orginalMovieData
    }
    
    private func configureTableView(){
        categoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.MovieCategoriesViewCell)
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        view.addSubview(categoriesTableView)
        categoriesTableView.anchor(top: self.view.topAnchor,left: self.view.leftAnchor, bottom:self.view.bottomAnchor,right: self.view.rightAnchor)
    }
}


extension MovieCategoriesViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: Cell.MovieCategoriesViewCell, for: indexPath)
        cell.textLabel?.text = movieViewModel.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let moviesVC = MovieViewController.instantiateStoryboard()
      moviesVC.movieViewModel = movieViewModel
      moviesVC.movieViewModel.isFilteredMovies = true
        categoriesMovies(movieViewModel.categories[indexPath.row])
      self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    private func categoriesMovies(_ subCategory: String){
        movieViewModel.movies = movieViewModel.getMoviesBySubCategories(movieViewModel.categoriesType, subCategory)
    }
    
}
