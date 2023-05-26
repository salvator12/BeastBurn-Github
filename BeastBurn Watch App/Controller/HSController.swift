//
//  HSController.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 25/05/23.
//

import CoreData

class HSController: ObservableObject {
    let container = NSPersistentContainer(name: "HighScoreModel")
    
    init() {
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
             
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data Saved")
        }catch{
            print("We could not saved the data")
        }
    }
}
