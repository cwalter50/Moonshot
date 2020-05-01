//
//  ContentView.swift
//  Moonshot
//
//  Created by Christopher Walter on 4/28/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State private var isShowingCrew = false
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
       NavigationView {
           List(missions) { mission in
               NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                   Image(mission.image)
                       .resizable()
                        .scaledToFit()
                       .frame(width: 44, height: 44)

                   VStack(alignment: .leading) {
                       Text(mission.displayName)
                           .font(.headline)
                    Text(self.isShowingCrew ? mission.formattedCrewMembersString : mission.formattedLaunchDate)

                   }
               }
           }
           .navigationBarTitle("Moonshot")
           .navigationBarItems(leading: Button(isShowingCrew ? "Crew Members" : "Dates") {
                self.isShowingCrew.toggle()
           })
           
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
