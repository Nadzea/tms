//
//  AboutCity.swift
//  swiftUIProject
//
//  Created by Надежда Клименко on 13.11.21.
//

import SwiftUI

struct AboutCity: View {
    var journey: Journey
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Date of visit: \(journey.dateOfJourney)")
                    .font(.title)
                    .italic()
                    .foregroundColor(.gray)
                Text("\(journey.country)")
                    .underline()
                    .foregroundColor(.pink)
                    .font(.title)
                Image("\(journey.imageName)").resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("\(journey.description)").padding([.top, .leading, .trailing], 20.0)
            }
        }
    }
}

struct AboutCity_Previews: PreviewProvider {
    static var previews: some View {
        AboutCity(journey: Journey(imageName: "lissabon", country: "Lisbon, Portugal", description: DescriptionOfTheCity.lisbon.rawValue))
    }
}
