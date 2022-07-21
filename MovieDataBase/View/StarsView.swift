//
//  StartView.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 20/07/22.
//

import Foundation
import UIKit

@IBDesignable class StarsView: UIView{
  
  var imageViewList = [UIImageView]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    updateView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @IBInspectable var rating: Double = 10.0{
    didSet {
      updateView()
      layoutIfNeeded()
    }
  }
  
  @IBInspectable
  var fillImage: UIImage = UIImage(named: "shapeFill.png")! {
    didSet {
    }
  }
  
  @IBInspectable
  var halfImage: UIImage = UIImage(named: "halfRate.png")! {
    didSet {
    }
  }
  
  @IBInspectable
  var emptyImage: UIImage = UIImage(named: "shapeEmpty.png")! {
    didSet {
    }
  }
  
  
  func updateView() {
    imageViewList.removeAll()
    subviews.forEach { (view) in
      view.removeFromSuperview()
    }
    let isHalf = Int(rating.rounded(.toNearestOrAwayFromZero)) - Int(rating) > 0
    
    for index in 1...10 {
      let imageView: UIImageView = UIImageView()
      imageView.image = Int(rating) >= index ?  fillImage : emptyImage
      if isHalf && (Int(rating + 1) == index){
        imageView.image = halfImage
      }
      imageView.tag = index
      imageView.contentMode = .scaleAspectFit
      imageViewList.append(imageView)
    }
    
    let stackView = UIStackView(arrangedSubviews: imageViewList)
    stackView.alignment = .fill
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 5.0
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
//    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//    stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//    stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//    stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
  }

}
