//
//  ViewController.swift
//  Project3-1
//
//  Created by Juan Cruz on 28/09/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    
   // var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
let fm = FileManager.default
   let path = Bundle.main.resourcePath!
   let items = try! fm.contentsOfDirectory(atPath: path)
        
       
         for i in items {
             if i.hasPrefix("spain"){
                 countries.append(i)
                 countries.sort()
             }
         }
      
        
        title = "International Flags"
        
        print(countries)
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
          // cell.textLabel?.text = countries[indexPath.row]
       // cell.imageView!.image = UIImage(systemName: "\(countries)")
        cell.imageView!.image = UIImage(named: "\(countries)")
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = countries[indexPath.row]
       //     vc.totalPictures =  pictures.count
         //   vc.selectedPictureNumber = indexPath.row + 1
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }


    
}

