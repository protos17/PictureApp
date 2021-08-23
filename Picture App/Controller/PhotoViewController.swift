//
//  PhotoViewController.swift
//  Picture App
//
//  Created by Данил Чапаров on 17.08.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var image: UIImage?
    var dateOfSave: Date?
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImage.image = image
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY, HH:mm:ss"
        let dateString = dateFormatter.string(from: dateOfSave!)
        dateLabel.text = "Картинка скачана: \(dateString)"
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                let alert = UIAlertController(title: "Успешно!", message: "Картинка успешно сохранена в памяти телефона!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        present(shareController, animated: true, completion: nil)
    }
}
