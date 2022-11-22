//
//  Order.swift
//  Cupcake Corner
//
//  Created by Clément Villanueva on 14/11/2022.
//

import SwiftUI

struct Order: Codable {
    
    var types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            city.trimmingCharacters(in: .whitespaces).isEmpty ||
            zip.trimmingCharacters(in: .whitespaces).isEmpty {
             return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // Comlicated cakes cost more
        cost += Double(type / 2)
        
        // $1 per cake more for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 per cake more for extra sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
