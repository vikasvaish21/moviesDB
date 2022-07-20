//
//  Extension.swift
//  MovieDataBase
//
//  Created by Vikas Vaish on 19/07/22.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,leading: NSLayoutXAxisAnchor? = nil,left: NSLayoutXAxisAnchor? = nil,bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil,trailing: NSLayoutXAxisAnchor? = nil,paddingTop: CGFloat = 0,paddingLeft:CGFloat = 0,paddingBottom:CGFloat = 0,paddingRight:CGFloat = 0,width: CGFloat? = nil,height : CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left,constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right,constant: -paddingRight).isActive = true
        }
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        if let trailing = trailing {
            leadingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant : width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant : height).isActive = true
        }
    }
}

extension UIViewController
{
  class func instantiateStoryboard(_ name: String = "Main") -> Self
  {
    return instantiateStoryboardHelper(name)
  }
  
  fileprivate class func instantiateStoryboardHelper<T>(_ name: String) -> T
  {
    let storyboard = UIStoryboard(name: name, bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
    return controller
  }
  
}


