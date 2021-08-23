//
//  StorageManager.swift
//  Picture App
//
//  Created by Данил Чапаров on 22.08.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ savedPhoto: SavedPhoto) {
        
        try! realm.write {
            realm.add(savedPhoto.self)
        }
    }
    
    static func deleteObjects(){
        
        try! realm.write {
            realm.deleteAll()
        }
    }
}
