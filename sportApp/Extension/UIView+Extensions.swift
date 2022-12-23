//
//  UIView+Extensions.swift
//  sportApp
//
//  Created by Celil Aydın on 23.12.2022.
//


import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {return cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}
