//
//  Person.swift
//  Project 12a
//
//  Created by Clément Villanueva on 07/08/2022.
//

import UIKit

class Person: NSObject, Codable {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
