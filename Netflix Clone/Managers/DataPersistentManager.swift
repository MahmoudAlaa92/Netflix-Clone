//
//  DataPersistentManager.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 27/06/2024.
//

import UIKit
import CoreData

enum dataSave: Error{
    case failToSaveData
    case successToSaveData
    case failToFetchData
}

class DataPersistentManager {
    
    static let shared = DataPersistentManager()
    
    func creatData(with model: Titles ,completion: @escaping (Result<Void ,Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let titleItemEntity = NSEntityDescription.entity(forEntityName: "TitleItem", in: managedContext) else{
            print("error in NSEntityDescription")
            return
        }
        let itemToSave = NSManagedObject(entity: titleItemEntity, insertInto: managedContext)
        
        itemToSave.setValue(model.id, forKey: "id")
        itemToSave.setValue(model.original_title, forKey: "original_title")
        itemToSave.setValue(model.original_name, forKey: "original_name")
        itemToSave.setValue(model.media_type, forKey: "media_type")
        itemToSave.setValue(model.overview, forKey: "overview")
        itemToSave.setValue(model.poster_path, forKey: "poster_path")
        itemToSave.setValue(model.release_date, forKey: "realse_data")
        itemToSave.setValue(model.vote_average, forKey: "vote_average")
        itemToSave.setValue(model.vote_count, forKey: "vote_count")
        
        do{
            try managedContext.save()
            completion(.success(()))
        }catch{
            completion(.failure(dataSave.failToSaveData))
        }
    }
    
    func fetchData(completion: @escaping (Result<[TitleItem] ,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TitleItem>(entityName:"TitleItem")
        
        do{
            let titleItem = try managedContext.fetch(fetchRequest)
            completion(.success(titleItem))
        }catch {
            completion(.failure(dataSave.failToFetchData))
            print("Error: ")
        }
        
    }
}
