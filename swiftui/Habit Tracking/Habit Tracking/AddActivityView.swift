//
//  AddActivityView.swift
//  Habit Tracking
//
//  Created by Clément Villanueva on 07/11/2022.
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    
    @Environment(\.dismiss)var dismiss
    
    @State private var title = ""
    @State private var description = ""
        
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Save") {
                    let item = Activity(title: title, description: description, timesCompleted: 1)
                    activities.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
