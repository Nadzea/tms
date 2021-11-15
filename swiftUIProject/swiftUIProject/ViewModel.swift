//
//  ViewModel.swift
//  swiftUIProject
//
//  Created by Надежда Клименко on 13.11.21.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var journeys: [Journey] = [
        Journey(imageName: "lissabon", country: "Lissbon, Portugal", description: DescriptionOfTheCity.lisbon.rawValue),
        Journey(imageName: "madrid", country: "Madrid, Spain", description: DescriptionOfTheCity.madrid.rawValue),
        Journey(imageName: "portofino-italy", country: "Portofino, Italy", description: DescriptionOfTheCity.portofino.rawValue),
        Journey(imageName: "USAGrandCanyon", country: "Arizona State, USA", description: DescriptionOfTheCity.USAGrandCanyon.rawValue),
        Journey(imageName: "USALas-Vegase", country: "Las Vegas, USA", description: DescriptionOfTheCity.USALas_Vegase.rawValue),
        Journey(imageName: "USANiagaraFalls", country: "New York State, USA", description: DescriptionOfTheCity.USANiagaraFalls.rawValue)]
}
