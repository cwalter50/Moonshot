//
//  AstronautView.swift
//  Moonshot
//
//  Created by Christopher Walter on 4/28/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut

        var matches = [Mission]()

        for mission in missions {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matches.append(mission)
            } else {
                print("astronaut: \(astronaut.id) was not on \(mission.displayName)")
//                fatalError("Missing \(member)")
            }
        }
        self.missions = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    ForEach(self.missions, id: \.id) { mission in
                        NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedLaunchDate)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
   
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
