//
//  SavedModel.swift
//  Picture App
//
//  Created by Данил Чапаров on 17.08.2021.
//

import RealmSwift

class SavedPhoto: Object {
    @Persisted var name: String?
    @Persisted var photo: Data
    @Persisted var id: String
    @Persisted var date: Date
}
