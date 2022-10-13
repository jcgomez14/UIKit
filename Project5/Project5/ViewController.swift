//
//  ViewController.swift
//  Project5
//
//  Created by Juan Cruz on 13/10/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(newRandom))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if  allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }

    func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    @objc func newRandom(){
        title = allWords.randomElement()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac ] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let loweranswer = answer.lowercased()
        
        
        guard isPossible(word: loweranswer) else {
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You cant just make stuff up")
            return
        }
        
        guard isOriginal(word: loweranswer) else {
            showErrorMessage(errorTitle: "Word used already", errorMessage: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: loweranswer) else {
            showErrorMessage(errorTitle: "Word not recognised", errorMessage: "That isn't a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
       
    }
    
    func isPossible(word: String) -> Bool{
        guard var tempWord = title?.lowercased() else {return false}
        
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
       return true
    }
    
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
        
      
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if word == title {
            return false
        } else if word.count < 3 {
            return false
        }
        
        return misspelledRange.location == NSNotFound
    }
    
    
    func showErrorMessage(errorTitle: String, errorMessage: String){
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        
    }
}


