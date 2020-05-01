//
//  Mission.swift
//  Moonshot
//
//  Created by Christopher Walter on 4/28/20.
//  Copyright © 2020 Christopher Walter. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedCrewMembersString: String {
        let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        var result = "Crew: "
        for member in crew
        {
            if let matchingAstronaut = astronauts.first(where: { $0.id == member.name }) {
                result += matchingAstronaut.name + ", "
            } else {
                fatalError("Missing \(member)")
            }
        }
        return result
    }
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    

    

}
