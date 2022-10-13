//
//  DetailViewController.swift
//  Project1
//
//  Created by Juan Cruz on 27/09/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    var selectedPictureNumber = 0
    var totalPictures = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = "Picture \(selectedPictureNumber) of \(totalPictures)"
        
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
 
        
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    @objc func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
            print("Image not found")
            return
        }
        
        
        let vc = UIActivityViewController(activityItems:[image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }


    



}
