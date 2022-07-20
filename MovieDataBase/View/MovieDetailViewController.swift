//
//  MovieDetailViewController.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 20/07/22.
//

import Foundation
import UIKit


class MovieDetailViewController: UIViewController{
    let movieDetail = MovieDetail()
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetail.frame = self.view.frame
        self.view = movieDetail
        movieDetail.configure(with: movie)
    }
}
