//
//  MovieListCell.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 19/07/22.
//

import UIKit
import Kingfisher
class MovieListCell: UITableViewCell {

    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }

    
    func setup(_ viewModel: Movie){
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.language
        yearLbl.text = viewModel.year
        yearLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        let url = URL(string: viewModel.poster)
        imagView.kf.indicatorType = .activity
        imagView.kf.setImage(with: url)
        imagView.layer.cornerRadius = 10
        imagView.layer.borderWidth = 1.0
        imagView.layer.borderColor = UIColor.black.cgColor

    }
    
}

