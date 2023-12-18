import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let price: String
}
