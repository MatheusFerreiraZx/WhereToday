//
//  ReservationFormView.swift
//  WhereTodayApp
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI

struct ReservationFormView: View {
    
    @EnvironmentObject var model:Model
    @State var showFormInvalidMessage = false
    @State var errorMessage = ""
    
    private var restaurant:RestaurantLocationModel
    @State var reservationDate = Date()
    @State var party:Int = 1
    @State var specialRequests:String = ""
    @State var customerName = ""
    @State var customerPhoneNumber = ""
    @State var customerEmail = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var temporaryReservation = ReservationModel()
    
    @State var mustChangeReservation = false
    
    init(_ restaurant:RestaurantLocationModel) {
        self.restaurant = restaurant
    }
    
    var body: some View {
        VStack {
            Form {
                RestaurantView(restaurant)
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("Data")
                            .font(.subheadline)
                        
                        TextField("",
                                  value: $party,
                                  formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .onChange(of: party) { value in
                            if value == 0 { party = 1}
                        }
                    }
                    
                    VStack {
                        DatePicker(selection: $reservationDate, in: Date()...,
                                   displayedComponents: [.date, .hourAndMinute]) {
                        }
                    }
                }
                .padding([.top, .bottom], 20)
                
                Group{
                    Group{
                        HStack{
                            Text("Nome: ")
                                .font(.subheadline)
                            TextField("Joga teu nome aqui...",
                                      text: $customerName)
                        }
                        
                        HStack{
                            Text("Telefone: ")
                                .font(.subheadline)
                            
                            TextField("Disk...",
                                      text: $customerPhoneNumber)
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                        }
                        
                        HStack{
                            Text("E-mail: ")
                                .font(.subheadline)
                            TextField("Seu e-mail...",
                                      text: $customerEmail)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        }
                        
                        
                        TextField("vai pedir algo especial hoje? (opcional)",
                                  text: $specialRequests,
                                  axis:.vertical)
                        .padding()
                        .overlay( RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2)) )
                        .lineLimit(6)
                        .padding([.top, .bottom], 20)
                    }
                
                    Button(action: {
                        validateForm()
                    }, label: {
                        Text("Confirmar")
                    })
                    .frame(maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                Spacer()
                }
            }
            .padding(.top, -40)
            .scrollContentBackground(.hidden)
            .onChange(of: mustChangeReservation) { _ in
                model.reservation = temporaryReservation
            }
            
            .alert("ERRO", isPresented: $showFormInvalidMessage, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(self.errorMessage)
            })
        }
        .onAppear {
            model.displayingReservationForm = true
        }
        .onDisappear {
            model.displayingReservationForm = false
        }
    }
    
    private func validateForm() {
        
        let nameIsValid = isValid(name: customerName)
        let emailIsValid = isValid(email: customerEmail)
        
        guard nameIsValid && emailIsValid
        else {
            var invalidNameMessage = ""
            if customerName.isEmpty || !isValid(name: customerName) {
                invalidNameMessage = "Nomes só podem conter letras e tem que ter mais de 3 caracteres\n\n"
            }
            
            var invalidPhoneMessage = ""
            if customerEmail.isEmpty {
                invalidPhoneMessage = "Esse campo não pode estar vazio.\n\n"
            }
            
            var invalidEmailMessage = ""
            if !customerEmail.isEmpty || !isValid(email: customerEmail) {
                invalidEmailMessage = "O email tá inválido e não pode estar vazio."
            }
            
            self.errorMessage = "Encontrado alguns erros no form:\n\n \(invalidNameMessage)\(invalidPhoneMessage)\(invalidEmailMessage)"
            
            showFormInvalidMessage.toggle()
            return
        }
        let temporaryReservation = ReservationModel(restaurant:restaurant,
                                               customerName: customerName,
                                               customerEmail: customerEmail,
                                               customerPhoneNumber: customerPhoneNumber,
                                               reservationDate:reservationDate,
                                               party:party,
                                               specialRequests:specialRequests)
        self.temporaryReservation = temporaryReservation
        self.mustChangeReservation.toggle()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty,
              name.count > 2
        else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

struct ReservationFormView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRestaurant = RestaurantLocationModel(city: "Las Vegas", neighborhood: "Downtown", phoneNumber: "(702) 555-9898")
        ReservationFormView(sampleRestaurant).environmentObject(Model())
    }
}
