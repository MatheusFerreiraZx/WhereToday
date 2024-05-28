//
//  Model.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import Foundation

class Model:ObservableObject {
  let restaurants = [
    RestaurantLocationModel(city: "Ruffo",
                       neighborhood: "Recife",
                       phoneNumber: ""),
    RestaurantLocationModel(city: "Cais Rooftop",
                       neighborhood: "Recife",
                       phoneNumber: "(81) 99146-8062"),
    RestaurantLocationModel(city: "Gildo Lanches",
                       neighborhood: "Recife",
                       phoneNumber: ""),
    RestaurantLocationModel(city: "Bode do nô",
                       neighborhood: "Olinda",
                       phoneNumber: "(81) 3429-8813"),
    RestaurantLocationModel(city: "Mini Mundo",
                       neighborhood: "Janga",
                       phoneNumber: "(54) 3286-4055"),
    RestaurantLocationModel(city: "Espigão",
                       neighborhood: "Olinda",
                       phoneNumber: "(81) 3493-1395")
  ]
  
  @Published var reservation = ReservationModel()
  @Published var displayingReservationForm = false
  @Published var temporaryReservation = ReservationModel()
  @Published var followNavitationLink = false
  
  @Published var displayTabBar = true
  @Published var tabBarChanged = false
  @Published var tabViewSelectedIndex = Int.max {
    didSet {
      tabBarChanged = true
    }
  }
}
