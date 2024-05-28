//
//  RestaurantLocationModel.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import Foundation

struct RestaurantLocationModel:Hashable {
  let city:String
  let neighborhood:String
  let phoneNumber:String
  
  init(city:String = "",
       neighborhood:String = "",
       phoneNumber:String = "") {
    self.city = city
    self.neighborhood = neighborhood
    self.phoneNumber = phoneNumber
  }
}
