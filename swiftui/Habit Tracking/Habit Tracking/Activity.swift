//
//  Activity.swift
//  Habit Tracking
//
//  Created by Clément Villanueva on 07/11/2022.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var timesCompleted: Int
}
