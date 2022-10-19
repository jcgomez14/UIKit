//
//  ViewController.swift
//  Project7
//
//  Created by Juan Cruz on 18/10/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var petitionsAll = [Petition]()
    var petitionsFilter = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(credits))
        let refreshRight = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        let searchRigth = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        
        
        
        self.navigationItem.rightBarButtonItems = [searchRigth,refreshRight]
        
        let urlString : String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        //Option 1  load url
     /*
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
      
      */
        
    //Option 2 load url
    if let url = URL(string: urlString){
        if let data = try? Data(contentsOf: url){
            parse(json: data)
            return
        }
    }
    showError()
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError(){
        let ac = UIAlertController(title:  "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    
    @objc func credits(){
        let ac = UIAlertController(title: "Credits", message: "API We The People de Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Thanks", style: .default))
        present(ac, animated: true)
    }
    
    @objc func search(){
        let ac = UIAlertController(title: "Search", message: "", preferredStyle: .alert)
        ac.addTextField()

        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac ] action in
            guard let search = ac?.textFields?[0].text else {return}
            self?.submit(search)
    }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func submit(_ search: String){

        petitionsAll = petitions
        
        petitionsFilter = petitionsAll.filter { $0.title.contains(search) }

        if petitionsFilter.isEmpty {
            showErrorSearch()
        } else {
            petitions.removeAll(keepingCapacity: true)
            petitions += petitionsFilter
            tableView.reloadData()
        }
        
    }
    
   @objc func refresh(){
        petitions = petitionsAll
        tableView.reloadData()
    }
    
    
    
    func showErrorSearch(){
        let ac = UIAlertController(title:  "Search error", message: "There are no results for your search", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    
}

