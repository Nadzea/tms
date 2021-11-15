//
//  JourneyView.swift
//  swiftUIProject
//
//  Created by Надежда Клименко on 8.11.21.
//

import SwiftUI

struct JourneyView: View {
    var journey: Journey
    var body: some View {
        
        HStack {
            Image(journey.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
            VStack(alignment: .center) {
                Text(journey.country)
                    .foregroundColor(.pink)
                Text(journey.dateOfJourney)
            }
            .padding(.leading, 0.0)
        }
        .frame(height: 150, alignment: .center)
    }
    
}

struct JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyView(journey: Journey(imageName: "lissabon", country: "Lisbon, Portugal", description: DescriptionOfTheCity.lisbon.rawValue))
    }
}
