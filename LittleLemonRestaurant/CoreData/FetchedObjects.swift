//
//  FetchedObjects.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import Foundation
import SwiftUI
import CoreData


struct FetchedObjects<T, Content>: View where T : NSManagedObject, Content : View {
    
  let content: ([T]) -> Content

  var request: FetchRequest<T>
  var results: FetchedResults<T>{ request.wrappedValue }
    
  init(
    predicate: NSPredicate = NSPredicate(value: true),
    sortDescriptors: [NSSortDescriptor] = [],
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    self.content = content
    self.request = FetchRequest(
      entity: T.entity(),
      sortDescriptors: sortDescriptors,
      predicate: predicate
    )
  }
  
  
  var body: some View {
    self.content(results.map { $0 })
  }
  
  
}
