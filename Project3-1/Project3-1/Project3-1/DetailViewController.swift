//
//  DetailViewController.swift
//  Project3-1
//
//  Created by Juan Cruz on 28/09/2022.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var imageView: UIImageView!
    
    var selectedImage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(systemName: "\(imageToLoad)")
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
    


}
