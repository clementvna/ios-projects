//
//  Picture.swift
//  Milestone 10-12
//
//  Created by Clément Villanueva on 09/08/2022.
//

import UIKit

class Picture: NSObject, Codable {
    
    var fileName: String?
    var caption: String?
    
    init(fileName: String, caption: String) {
        self.fileName = "Unknown"
        self.caption = "Empty"
    }

}
