//
//  ReservationView.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI

struct ReservationView: View {
    @EnvironmentObject var model:Model
    
    var body: some View {
        let restaurant = model.reservation.restaurant
        
        ScrollView {
            VStack {
                LogoView()
                    .padding(.bottom, 20)
                
                if restaurant.city.isEmpty {
                    VStack {
                        Text("Tu não marcasse nenhuma atividade pra hoje, pô")
                            .foregroundColor(.red)
                            .padding([.leading, .trailing], 40)
                            .padding([.top, .bottom], 100)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                    }
                    .frame(maxHeight:.infinity)
                } else {
                    Text("Eita, tem pra hoje:")
                        .padding([.leading, .trailing], 40)
                        .padding([.top, .bottom], 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Rolê")
                                .font(.subheadline)
                                .padding(.bottom, 5)
                            RestaurantView(restaurant)
                        }
                        Spacer()
                    }
                    .frame(maxWidth:.infinity)
                    .padding(.bottom, 20)
                    
                    Divider()
                        .padding(.bottom, 20)
                    
                    VStack {
                        HStack {
                            Text("Nome: ")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                            Text(model.reservation.customerName)
                            Spacer()
                        }
                        
                        HStack {
                            Text("E-mail: ")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                            Text(model.reservation.customerEmail)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Telefone: ")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                            Text(model.reservation.customerPhoneNumber)
                            Spacer()
                        }
                        
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("Festa: ")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
                        Text("\(model.reservation.party)")
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        HStack {
                            Text("Data: ")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                            Text(model.reservation.reservationDate, style: .date)
                            Spacer()
                        }
                        
                        HStack {
                            Text("Hora: ")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                            Text(model.reservation.reservationDate, style: .time)
                            Spacer()
                        }
                    }
                    .padding(.bottom, 20)
                    
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Pedidos especiais:")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Text(model.reservation.specialRequests)
                        }
                        Spacer()
                    }
                    .frame(maxWidth:.infinity)
                }
            }
        }
        .padding(50)
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView().environmentObject(Model())
    }
}
