//
//  String+Ext.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 07/05/22.
//

import Foundation

extension String {
    
    func capitalizedFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
