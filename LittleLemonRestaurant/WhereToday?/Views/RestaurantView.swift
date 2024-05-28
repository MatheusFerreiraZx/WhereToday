//
//  RestaurantView.swift
//  WhereTodayApp
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI

struct RestaurantView: View {
  private var restaurant:RestaurantLocationModel
  
  init(_ restaurant:RestaurantLocationModel) {
    self.restaurant = restaurant
  }
  
  var body: some View {
    VStack (alignment: .leading, spacing:3){
      Text(restaurant.city)
        .font(.title)
      
      HStack {
        Text(restaurant.neighborhood)
        Text("–")
        Text(restaurant.phoneNumber)
      }
      .font(.title3)
      .foregroundColor(.blue)
    }
  }
}

struct Restaurant_Previews: PreviewProvider {
  static var previews: some View {
    let sampleRestaurant = RestaurantLocationModel(city: "Las Vegas", neighborhood: "Downtown", phoneNumber: "(702) 555-9898")
    RestaurantView(sampleRestaurant)
    
  }
}
