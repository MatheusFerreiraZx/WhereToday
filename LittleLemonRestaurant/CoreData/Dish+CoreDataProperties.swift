import Foundation
import CoreData


extension Dish {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }
    
    @NSManaged public var name: String? 
    @NSManaged public var price: Float
    @NSManaged public var size: String?
    @NSManaged public var fromCustomer: NSSet?
    @NSManaged public var fromLocation: NSSet?

}

extension Dish {
    
    @objc(addFromCustomerObject:)
    @NSManaged public func addToFromCustomer(_ value: Customer)
    
    @objc(removeFromCustomerObject:)
    @NSManaged public func removeFromFromCustomer(_ value: Customer)
    
    @objc(addFromCustomer:)
    @NSManaged public func addToFromCustomer(_ values: NSSet)
    
    @objc(removeFromCustomer:)
    @NSManaged public func removeFromFromCustomer(_ values: NSSet)
    
}

extension Dish {
    
    @objc(addFromLocationObject:)
    @NSManaged public func addToFromLocation(_ value: Location)
    
    @objc(removeFromLocationObject:)
    @NSManaged public func removeFromFromLocation(_ value: Location)
    
    @objc(addFromLocation:)
    @NSManaged public func addToFromLocation(_ values: NSSet)
    
    @objc(removeFromLocation:)
    @NSManaged public func removeFromFromLocation(_ values: NSSet)
    
}

extension Dish : Identifiable {
    

    static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    
    static func with(name: String,
                     _ context:NSManagedObjectContext) -> Dish? {
        let request = Dish.request()
        
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "name",
                                              ascending: false,
                                              selector: #selector(NSString .localizedStandardCompare))
        request.sortDescriptors = [sortDescriptor]
        
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count == 1,
                  let dish = results.first
            else { return Dish(context: context) }
            return dish
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func delete(with name: String,
                       _ context:NSManagedObjectContext) -> Bool {
        let request = Dish.request()
        
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count == 1,
                  let dish = results.first
            else {
                return false
            }
            context.delete(dish)
            return true
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
    
    class func deleteAll(_ context:NSManagedObjectContext) {
        let request = Dish.request()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
            save(context)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }


    static func save(_ context:NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    
    class func readAll(_ context:NSManagedObjectContext) -> [Dish]? {
        let request = Dish.request()
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count > 0 else { return nil }
            return results
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
}

