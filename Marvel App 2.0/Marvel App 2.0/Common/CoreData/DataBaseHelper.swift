//
//  DataBaseHelper.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/15/24.
//

import Foundation
import UIKit
import CoreData

class DataBaseHelper {

    
    private let controller: NSFetchedResultsController<FavoriteHero>
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {fatalError()}
        let request = FavoriteHero.fetchRequest()
        let managedContext = appDelegate.persistentContainer.viewContext
        controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func requestFavorites(completion: @escaping ((Result<[FavoriteHero], Error>) -> Void)) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteHero")

        controller.managedObjectContext.performAndWait {
   
            do {
                try self.controller.performFetch()
                let savedMovies = try managedContext.fetch(fetchRequest) as? [FavoriteHero]
                completion(.success(savedMovies ?? []))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func save(hero: HeroToCoreData) {
        controller.managedObjectContext.performAndWait {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "FavoriteHero",in: managedContext)!
            let newHero = Hero(entity: entity, insertInto: managedContext)
                 
            newHero.name = hero.name
            newHero.imageUrl = hero.imageURL
            newHero.summary = hero.summary
            
            self.controller.managedObjectContext.insert(newHero)
            try? self.controller.managedObjectContext.save()
        }
    }
    
    func delete(hero: FavoriteHero) {
        
        controller.managedObjectContext.performAndWait {
            self.controller.managedObjectContext.delete(hero)
            try? self.controller.managedObjectContext.save()
        }
    }
    
}


@objc(FavoriteHero)
public class FavoriteHero: NSManagedObject {
    

}


extension FavoriteHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteHero> {
       
        let request = NSFetchRequest<FavoriteHero>(entityName:"FavoriteHero")
        request.sortDescriptors = []
        return request
        
    }

    @NSManaged public var name: String
    @NSManaged public var summary: String
    @NSManaged public var imageUrl: String

}

extension FavoriteHero : Identifiable {

}

