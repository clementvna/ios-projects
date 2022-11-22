//
//  GridLayout.swift
//  Moonshot
//
//  Created by Clément Villanueva on 01/11/2022.
//

import SwiftUI

struct GridLayout: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    var missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                    .padding(5)
                }
            }
        }
    }
    
    init(astronauts: [String: Astronaut], missions: [Mission]) {
        self.astronauts = astronauts
        self.missions = missions
    }
}

struct GridLayout_Previews: PreviewProvider {
    static var previews: some View {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        GridLayout(astronauts: astronauts, missions: missions)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
