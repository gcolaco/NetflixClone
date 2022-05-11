//
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 11/05/22.
//

import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    private init() {}
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.originalTitle = model.originalTitle
        item.id = Int64(model.id)
        item.title = model.title
        item.overview = model.overview
        item.mediaType = model.mediaType
        item.posterPath = model.posterPath
        item.releaseDate = model.releaseDate
        item.voteCount = Int64(model.voteCount)
        item.voteAverage = model.voteAverage
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToSaveData))
        }
    }
    
    
    func fetchTitlesFromDataBase(completion: @escaping (Result<[TitleItem], DatabaseError>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(.failedToFetchData))
        }
        
    }
    
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToDeleteData))
        }
        
    }
    
    
}
