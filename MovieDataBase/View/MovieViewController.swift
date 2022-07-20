//
//  MovieViewController.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 19/07/22.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    var movieViewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        movieSearchBar.delegate = self
        self.movieSearchBar.endEditing(true)
        // Do any additional setup after loading the view.
    }
    
    private func configureTableView(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: Cell.MovieListCell, bundle: nil), forCellReuseIdentifier: Cell.MovieListCell)
    }
    
    private func configureUI() {
        moviesTableView.keyboardDismissMode = .onDrag
        moviesTableView.allowsSelection = true
        movieSearchBar.isHidden = movieViewModel.isFilteredMovies
    }

}

extension MovieViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieViewModel.isFilteredMovies ? movieViewModel.movies.count : MovieEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = registerAndSetUpCell(tableView, indexPath)
        return cell
    }
    
    func registerAndSetUpCell(_ tableView:UITableView,_ indexPath: IndexPath) -> UITableViewCell{
        let identifier = movieViewModel.isFilteredMovies ? CellType.MovieListCell.rawValue : CellType.cell.rawValue
        
        if movieViewModel.isFilteredMovies{
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MovieListCell
            cell.setup(movieViewModel.movies[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            cell.textLabel?.text = MovieEnum.getType(indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if movieViewModel.isFilteredMovies{
            let movieDetailVC = MovieDetailViewController.instantiateStoryboard()
            movieDetailVC.movie = movieViewModel.movies[indexPath.row]

            self.navigationController?.pushViewController(movieDetailVC, animated: true)
        }else{
            let movieCategoryVC = MovieCategoriesViewController.instantiateStoryboard()
            movieCategoryVC.movieViewModel = movieViewModel
            movieViewModel.filterMoviesCategories(MovieEnum.allCases[indexPath.row])
            self.navigationController?.pushViewController(movieCategoryVC, animated: true)
        }
    }
    
}

extension MovieViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieViewModel.movies = searchText.count > 0 ? movieViewModel.searchMoviesText(searchText.replacingOccurrences(of: " ", with: "")) : movieViewModel.orginalMovieData
        movieViewModel.isFilteredMovies = searchText.count > 0
        moviesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieViewModel.isFilteredMovies = false
        movieViewModel.movies = movieViewModel.orginalMovieData
        moviesTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
        
}
