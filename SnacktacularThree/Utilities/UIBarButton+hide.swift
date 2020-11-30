//
//  UIBarButton+hide.swift
//  SnacktacularThree
//
//  Created by James Monahan on 11/15/20.
//

import UIKit

extension UIBarButtonItem{
    func hide(){
        self.isEnabled = false
        self.tintColor = .clear
    }
}
