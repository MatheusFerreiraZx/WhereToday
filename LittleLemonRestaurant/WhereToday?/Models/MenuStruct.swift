//
//  MenuStruct.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
}
