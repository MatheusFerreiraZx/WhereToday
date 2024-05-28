//
//  OurDishesView.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI
import CoreData

struct OurDishesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishesModel = DishesModel()
    @State private var showAlert = false
    @State var searchText = ""
    
    var body: some View {
        VStack {
            LogoView()
                .padding(.bottom, 10)
                .padding(.top, 50)
            
            NavigationView {
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                DisplayDishView(dish)
                                    .onTapGesture {
                                        showAlert.toggle()
                                    }
                            }
                        }
                        .searchable(text: $searchText,
                                    prompt: "Pesquisa...")
                    }
            }
            
            Spacer()
            
            DailyMessageView()
                .padding(.top, 40)

            .padding(.top, -10)
            .alert("Compromisso marcado, obrigado!",
                   isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
                   .scrollContentBackground(.hidden)
                   .task {
                       await dishesModel.reload(viewContext)
                   }
        }
    }
    
    private func buildPredicate() -> NSPredicate {
        return searchText == "" ?
        NSPredicate(value: true) :
        NSPredicate(format: "nome contém[cd] %@", searchText)
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
        [NSSortDescriptor(key: "name",
                          ascending: true,
                          selector:
                            #selector(NSString.localizedStandardCompare))]
    }
}

struct OurDishes_Previews: PreviewProvider {
    static var previews: some View {
        OurDishesView()
    }
}






