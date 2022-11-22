//
//  ActivityDetailsView.swift
//  Habit Tracking
//
//  Created by Clément Villanueva on 09/11/2022.
//

import SwiftUI

struct ActivityDetailsView: View {
    var activity: Activity
    var activities: Activities
    
    init(activity: Activity, activities: Activities) {
        self.activity = activity
        self.activities = activities
    }
    
    var body: some View {
        VStack {
            Text(activity.description)
            
            Text("Completed \(activity.timesCompleted) times.")
                .padding(10)
            
            Button {
                let newActivity = Activity(title: activity.title, description: activity.description, timesCompleted: activity.timesCompleted + 1)
                
                if let index = activities.items.firstIndex(of: activity) {
                    activities.items[index] = newActivity
                }
            } label: {
                Text("Complete again")
                    .padding(10)
            }
        }
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static let activity = Activity(title: "Running", description: "I ran 10 miles today.", timesCompleted: 5)
    static let activities = Activities()
    
    static var previews: some View {
        ActivityDetailsView(activity: activity, activities: activities)
    }
}
