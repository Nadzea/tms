//
//  SecondContentView.swift
//  swiftUIProject
//
//  Created by Надежда Клименко on 11.11.21.
//

import SwiftUI

struct SecondContentView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Button(action: {isPresented = false}, label: {
                    Text("Back").font(.subheadline)
                        .accentColor(.black)
                })
                .frame(width: 80.0, height: 40.0)
                .background(Color.init(red: 0.5, green: 0.8, blue: 0.3))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.8), radius: 10, x: 5, y: 5)
                
                List {
                    ForEach(viewModel.journeys, id: \.self) { journey in
                        
                        NavigationLink(
                            destination: AboutCity(journey: journey),
                            label: {
                                JourneyView(journey: journey)
                            })
                    }
                }.navigationTitle("My journeys")
            }
        }
    }
}

struct SecondContentView_Previews: PreviewProvider {
    static var previews: some View {
        SecondContentView(isPresented: .constant(false))
    }
}
