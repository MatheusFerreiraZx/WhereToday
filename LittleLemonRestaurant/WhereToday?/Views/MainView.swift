//
//  MainView.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var model = Model()
    @State var tabSelection = 0
    @State var previousTabSelection = -1
    
    var body: some View {
        TabView (selection: $model.tabViewSelectedIndex){
            LocationsView()
                .tag(0)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Restaurantes", systemImage: "fork.knife")
                    }
                }
                .onAppear() {
                    tabSelection = 0
                }
            
            OurDishesView()
                .tag(1)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Tipos de rolê", systemImage: "fork.knife.circle")
                    }
                }
                .onAppear() {
                    tabSelection = 1
                }

            ReservationView()
                .tag(2)
                .tabItem {
                    if !model.displayingReservationForm {
                        Label("Minhas Reservas", systemImage: "square.and.pencil")
                    }
                }
                .onAppear() {
                    tabSelection = 2
                }
        }
        .id(tabSelection)
        .environmentObject(model)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Model())
    }
}
