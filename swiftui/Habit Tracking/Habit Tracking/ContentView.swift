//
//  ContentView.swift
//  Habit Tracking
//
//  Created by Clément Villanueva on 07/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        ActivityDetailsView(activity: item, activities: activities)
                    } label : {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habit Tracking")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
