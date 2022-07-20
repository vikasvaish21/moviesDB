//
//  MovieDetail.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 20/07/22.
//
import Foundation
import UIKit


class MovieDetail: UIView{
  
  private var title: UILabel!
  private var releasedDate: UILabel!
  private var genre: UILabel!
  private var rating: UILabel!
  private var plot: UILabel!
  private var poster: UIImageView!
  private var starView: StarsView!
  private var pickerview: UIPickerView!
  private var sourceRating:[Rating]?
  private var ratingLbl: UILabel!
  private var stackView: UIStackView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI(){
    setupUI()
    self.backgroundColor = .white
  }
    
    public func configure(with movie: Movie) {
        starView.rating = Double(String(movie.imdbRating ?? "")) ?? 0
        sourceRating = movie.ratings
        title.text = movie.title
        genre.text = movie.genre
        releasedDate.text = movie.released
        rating.text = movie.imdbRating
        plot.text = movie.plot
        ratingLbl.text = (sourceRating?[0].source ?? "")   + " Ratings -> " + (sourceRating?[0].value ?? "")
        if  let url = URL(string: movie.poster) {
            poster.kf.indicatorType = .activity
            poster.kf.setImage(with: url)
            
        }
    }
  
  
  private func pickerViewSetup(){
    pickerview = UIPickerView(frame: CGRect(x: self.frame.origin.x , y: ratingLbl.frame.origin.y, width: self.frame.width, height: 100))
    pickerview.dataSource = self
    pickerview.delegate = self
  }
  
    private func stackViewSetup(){
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 100, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
    }
    
    private func posterSetup(){
        poster = UIImageView()
        stackView.addArrangedSubview(poster)
        poster.anchor(paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 100)
        poster.layer.borderWidth = 1.0
        poster.layer.borderColor = UIColor.black.cgColor
    }
    
    private func starViewSetup(){
    starView = StarsView(frame: CGRect(x: self.frame.origin.x , y: plot.frame.origin.y + 100, width: 100, height: 30))
    starView.tintColor = .blue
  }
  
  private func setupUI() {
 
    stackViewSetup()
    posterSetup()
    allLabelSetup()
    starViewSetup()
    pickerViewSetup()

    let textStackView = UIStackView()
    textStackView.axis = .vertical
    textStackView.distribution = .fill
    textStackView.alignment = .leading
    textStackView.spacing = 4
    textStackView.addArrangedSubview(title)
    textStackView.addArrangedSubview(genre)
    textStackView.addArrangedSubview(releasedDate)
    textStackView.addArrangedSubview(rating)
    textStackView.addArrangedSubview(plot)
    textStackView.addArrangedSubview(ratingLbl)
    textStackView.addArrangedSubview(starView)
    textStackView.addArrangedSubview(pickerview)
    stackView.addArrangedSubview(textStackView)
  }
  
  private func allLabelSetup(){
    title = UILabel()
    title.font = .boldSystemFont(ofSize: 14)
    title.numberOfLines = 0
    title.lineBreakMode = .byWordWrapping
    
    releasedDate = UILabel()
    releasedDate.font = .systemFont(ofSize: 14)
    releasedDate.numberOfLines = 3
    releasedDate.lineBreakMode = .byTruncatingTail
    
    genre = UILabel()
    genre.font = .systemFont(ofSize: 14)
    genre.numberOfLines = 0
    genre.lineBreakMode = .byTruncatingTail
    
    plot = UILabel()
    plot.font = .systemFont(ofSize: 12)
    plot.numberOfLines = 10
    plot.lineBreakMode = .byTruncatingTail
    
    rating = UILabel()
    rating.numberOfLines = 3
    rating.font = .boldSystemFont(ofSize: 12)
    rating.lineBreakMode = .byTruncatingTail
    
    ratingLbl = UILabel()
    ratingLbl.font = .boldSystemFont(ofSize: 12)
    ratingLbl.lineBreakMode = .byCharWrapping
  }
}
extension MovieDetail: UIPickerViewDelegate{
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    calculateRating(sourceRating?[row].source ?? "0", sourceRating?[row].value ?? "0");
    ratingLbl.text  = (sourceRating?[row].source ?? "")   + " Ratings -> " + (sourceRating?[row].value ?? "")
  }
  
}

extension MovieDetail: UIPickerViewDataSource{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return sourceRating?.count ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel: UILabel? = (view as? UILabel)
      if pickerLabel == nil {
          pickerLabel = UILabel()
          pickerLabel?.font = .boldSystemFont(ofSize: 12)
          pickerLabel?.textAlignment = .left
      }
      pickerLabel?.text  = (sourceRating?[row].source ?? "")   + " Ratings -> " + (sourceRating?[row].value ?? "")
    pickerLabel?.textColor = UIColor.darkGray
      return pickerLabel!
  }
  
  private func calculateRating(_ source: String, _ value: String){
    
   let ratingType = RatingType(rawValue: source)
    var rating: Double!
    
    switch ratingType{
    case .Internet:
      let stringValue = value.split(separator: "/").first
      rating = Double(stringValue ?? "0")
      break
    case .Metacritic:
      let stringValue = value.split(separator: "/").first
      rating = (Double(stringValue!)!) / 10
      break
    case .Rotten:
      let stringValue = value.split(separator: "%").first
      rating = (Double(stringValue!)!) / 10
      break
    default:
      break
    }
    starView.rating = rating
  }
}
