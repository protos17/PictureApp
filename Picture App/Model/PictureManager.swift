//
//  PictureManager.swift
//  Picture App
//
//  Created by Данил Чапаров on 17.08.2021.
//

import UIKit
import RealmSwift

protocol PictureManagerDelegate {
    func updateTableView()
}

class PictureManager {
    
    var pictureData = [PictureData]()
    var delegate: PictureManagerDelegate?
    
    func fetchPicture() {
        let urlString = "\(K.unsplashURL)\(K.apiKey)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                self.pictureData = try decoder.decode([PictureData].self, from: data)
                DispatchQueue.main.async {
                    self.delegate?.updateTableView()
                    self.savePicture()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func savePicture() {
        
        for picture in pictureData {
            
            let pictureURL = picture.urls.regular
            guard let imageURL = URL(string: pictureURL) else { return }
            
            guard let image = try? Data(contentsOf: imageURL) else { return }
            
            let savedPhoto = SavedPhoto()
            savedPhoto.name = picture.altDescription ?? ""
            savedPhoto.id = picture.id
            savedPhoto.photo = image
            savedPhoto.date = Date(timeIntervalSinceNow: 1)
            
            StorageManager.saveObject(savedPhoto)
        }
    }
}
