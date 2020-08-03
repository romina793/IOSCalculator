//
//  UIButtonExternsion.swift
//  IOS-Calculator
//
//  Created by Romina Pozzuto on 02/08/2020.
//  Copyright © 2020 Romina Pozzuto. All rights reserved.
//

import UIKit

extension UIButton{
    
    // Borde redondo
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    // Brilla
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }

}
