import SwiftUI
import CoreData

struct OurDishes: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var dishesModel = DishesModel()
    @State private var showAlert = false
    @State var searchText = ""
    
    
    var body: some View {
        VStack {
            LittleLemonLogo()
                .padding(.bottom, 10)
                .padding(.top, 50)
            
            Text ("Tap to order")
                .foregroundColor(.black)
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 8)
                .background(Color("approvedYellow"))
                .cornerRadius(20)
            
            
            NavigationView {
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                DisplayDish(dish)
                                    .onTapGesture {
                                        showAlert.toggle()
                                    }
                            }
                        }
                        .searchable(text: $searchText,
                                    prompt: "search...")
                    }
            }
            

            .padding(.top, -10)
            
            .alert("Order placed, thanks!",
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
        NSPredicate(format: "name CONTAINS[cd] %@", searchText)
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
        OurDishes()
    }
}






