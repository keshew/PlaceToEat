//
//  storageManager.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 29.07.2022.
//

import RealmSwift

let realm = try! Realm()

class storageManager {
    
    static func saveObjc(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place) {
        try! realm.write {
            realm.delete(place)
            
        }
    }
    
}
