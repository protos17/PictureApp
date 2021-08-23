//
//  ViewController.swift
//  Picture App
//
//  Created by Данил Чапаров on 17.08.2021.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var pictureManager = PictureManager()
    var savedPhoto: Results<SavedPhoto>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureManager.delegate = self
        pictureManager.fetchPicture()
        savedPhoto = realm.objects(SavedPhoto.self)
    }
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        
        pictureManager.fetchPicture()
    }
    
    @IBAction func deleteObjects(_ sender: UIBarButtonItem) {
        
        DispatchQueue.main.async {
            StorageManager.deleteObjects()
            let alert = UIAlertController(title: "Все картинки удалены!", message: "Нажмите кнопку ,,Обновить'', чтобы получить картинки", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            self.collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.photoSegue {
            let photoVC = segue.destination as! PhotoViewController
            let cell = sender as! PhotoCell
            photoVC.image = cell.photoImageView.image
            photoVC.dateOfSave = cell.dateOfSave
        }
    }
}

//MARK: - PictureManagerDelegate

extension PhotoCollectionViewController: PictureManagerDelegate {
    
    func updateTableView() {
        collection.reloadData()
    }
}

//MARK: - UICollectionViewDataSource

extension PhotoCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedPhoto.isEmpty ? 0 : savedPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! PhotoCell
        
        let picture = savedPhoto[indexPath.item]
        
        DispatchQueue.main.async {
            cell.descriptionLabel.text = picture.name ?? picture.id
            cell.photoImageView.image = UIImage(data: picture.photo)
            cell.dateOfSave = picture.date
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
