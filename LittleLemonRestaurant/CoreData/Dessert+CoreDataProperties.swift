import Foundation
import CoreData


extension Dessert {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dessert> {
        return NSFetchRequest<Dessert>(entityName: "Dessert")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var size: String?
    @NSManaged public var fromCustomer: NSSet?
    @NSManaged public var fromLocation: NSSet?

}

extension Dessert {

    @objc(addFromCustomerObject:)
    @NSManaged public func addToFromCustomer(_ value: Customer)

    @objc(removeFromCustomerObject:)
    @NSManaged public func removeFromFromCustomer(_ value: Customer)

    @objc(addFromCustomer:)
    @NSManaged public func addToFromCustomer(_ values: NSSet)

    @objc(removeFromCustomer:)
    @NSManaged public func removeFromFromCustomer(_ values: NSSet)

}

extension Dessert {

    @objc(addFromLocationObject:)
    @NSManaged public func addToFromLocation(_ value: Location)

    @objc(removeFromLocationObject:)
    @NSManaged public func removeFromFromLocation(_ value: Location)

    @objc(addFromLocation:)
    @NSManaged public func addToFromLocation(_ values: NSSet)

    @objc(removeFromLocation:)
    @NSManaged public func removeFromFromLocation(_ values: NSSet)

}

extension Dessert : Identifiable {

}
