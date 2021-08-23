//
//  PhotoCell.swift
//  Picture App
//
//  Created by Данил Чапаров on 17.08.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var dateOfSave: Date?
}
