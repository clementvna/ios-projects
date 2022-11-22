//
//  ListLayout.swift
//  Moonshot
//
//  Created by Clément Villanueva on 01/11/2022.
//

import SwiftUI

struct ListLayout: View {
    var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    var missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            HStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .frame(minWidth: 250, maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white.opacity(0.5))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.horizontal)
                    }
                    CustomDivider()
                }
            }
        }
    }
    
    init(astronauts: [String: Astronaut], missions: [Mission]) {
        self.astronauts = astronauts
        self.missions = missions
    }
}

struct ListLayout_Previews: PreviewProvider {
    static var previews: some View {
        let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        ListLayout(astronauts: astronauts, missions: missions)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
