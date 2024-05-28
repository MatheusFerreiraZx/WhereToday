//
//  DisplayDishView.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI

struct DisplayDishView: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        HStack{
            Text(dish.name ?? "")
                .padding([.top, .bottom], 7)
                .padding(.leading, 20)

            Spacer()

            Text(dish.formatPrice())
                .monospaced()
                .font(.callout)
                .padding(.trailing, 30)
        }
        .contentShape(Rectangle())
    }
}

struct DisplayDish_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DisplayDishView(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.name = "Heineken"
        dish.price = 24.50
        dish.size = "Da grande, papai"
        return dish
    }
}
