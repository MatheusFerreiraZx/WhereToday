//
//  CustomerExtension.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import Foundation
import CoreData

extension Customer {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var email: String?
    @NSManaged public var fistName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var fromLocation: NSSet?
    @NSManaged public var toDessert: NSSet?
    @NSManaged public var toDish: NSSet?
}

extension Customer {

    @objc(addFromLocationObject:)
    @NSManaged public func addToFromLocation(_ value: Location)

    @objc(removeFromLocationObject:)
    @NSManaged public func removeFromFromLocation(_ value: Location)

    @objc(addFromLocation:)
    @NSManaged public func addToFromLocation(_ values: NSSet)

    @objc(removeFromLocation:)
    @NSManaged public func removeFromFromLocation(_ values: NSSet)

}

extension Customer : Identifiable {

    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    
    static func with(firstName: String,
                     lastName:String,
                     _ context:NSManagedObjectContext) -> Customer? {
        let request = Customer.request()
        
        let predicate = NSPredicate(format: "fistName == %@ AND lastName == %@", firstName, lastName)
        request.predicate = predicate
                
        do {
            guard let results = try context.fetch(request) as? [Customer],
                  results.count > 0
            else { return nil }
            return results.first
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
}
