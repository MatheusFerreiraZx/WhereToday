//
//  LocationsViews.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI

struct LocationsView: View {
    @EnvironmentObject var model:Model
    
    var body: some View {
        VStack {
            LogoView()
                .padding(.top, 40)
                .font(.title)
            
            Text (model.displayingReservationForm ? "Detalhe do rolê" : "Restaurantes da semana")
            .padding([.leading, .trailing], 50)
            .padding([.top, .bottom], 8)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(20)
            .bold()
            
            NavigationView {
                List(model.restaurants, id: \.self) { restaurant in
                    NavigationLink(destination: ReservationFormView(restaurant)) {
                        RestaurantView(restaurant)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            
            .onDisappear{
                if model.tabBarChanged { return }
        
                model.displayingReservationForm = true
            }
            .frame(maxHeight: .infinity)
            .padding(.top, -10)
            .scrollContentBackground(.hidden)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView().environmentObject(Model())
    }
}
