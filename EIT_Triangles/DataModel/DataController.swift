//
//  DataController.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 09.08.2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Patients")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data: \(error.localizedDescription)")
            }
        }
    }
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Success!")
        } catch {
            print("Failed to save the data")
        }
    }
    func addPatient(fullname: String, age: String, diagnosis: String, eitlink: String, context: NSManagedObjectContext) {
        let patient = Patients(context: context)
        
        patient.id = UUID()
        patient.age = age
        patient.fullname = fullname
        patient.diangosis = diagnosis
        patient.eitlink = eitlink
        patient.date = Date()
        
        save(context: context)
    }
    
    func editPatient(patient: Patients, fullname: String, age: String, diagnosis: String, eitlink: String, context: NSManagedObjectContext) {
        
        patient.age = age
        patient.fullname = fullname
        patient.diangosis = diagnosis
        patient.eitlink = eitlink
        patient.date = Date()
        
        save(context: context)
    }
}
