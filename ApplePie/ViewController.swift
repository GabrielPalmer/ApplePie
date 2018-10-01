//
//  ViewController.swift
//  ApplePie
//
//  Created by Gabriel Blaine Palmer on 9/22/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var logTableView: UITableView!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var currentGame: Game!
    
    let incorrectMovesAllowed = 7
    var totalWins = 0
    var totalLosses = 0
    
    var logEntries: [String] = []
    var roundsWon: [Bool] = []
    
    var listOfWords: [String] = ["piano", "box", "fish", "lightning", "table", "fire", "street", "cold", "book", "knife", "candy", "game", "clock", "music", "food", "sock", "sun", "picture", "chair", "wind", "computer", "plant", "dirt", "glass", "door", "mountain", "flower", "jazz", "power", "water", "hand", "hair", "potato", "cool", "color", "camping", "television", "icosahedron", "truck", "road", "plane", "wheel", "letter", "coordinate", "bullet", "jump", "battery", "shell", "fart", "beard", "machine", "stomach", "backpack", "fan", "board", "laser", "pie", "fruit", "stop", "grass", "keychain", "pen", "question", "bone", "lazy", "desk", "call", "error", "knot", "rip", "ocean", "crash", "guacamole", "beam", "season", "exit", "shelf", "space", "bag", "tooth", "strength", "bottle", "plumber", "wire", "ground", "person", "flip", "tag", "message", "glue", "broom", "bucket", "sink", "cut", "burn", "bush", "gas", "alabama", "mississippi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newRound()
    }

    //MARK: Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    //MARK: TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if logEntries.count > 12 {
            logEntries.removeFirst()
            roundsWon.removeFirst()
        }
        return logEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        
        let word = logEntries[indexPath.row]
        cell.textLabel?.text = word
        cell.textLabel?.textColor = roundsWon[indexPath.row] ? UIColor.green : UIColor.red
        
        return cell
    }
    
    //MARK: Custom Functions
    
    func updateUI() {
        
        correctWordLabel.text = currentGame.formattedWord
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "apples\(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        
        if currentGame.incorrectMovesRemaining == 0 {
            
            totalLosses += 1
            logEntries.append(currentGame.word.capitalized)
            roundsWon.append(false)
            newRound()
            
        } else if currentGame.word == currentGame.formattedWord.replacingOccurrences(of: " ", with: ""){
            
            totalWins += 1
            logEntries.append(currentGame.word.capitalized)
            roundsWon.append(true)
            newRound()
            
        } else {
            updateUI()
        }
    }
    
    func newRound() {
        
        logTableView.reloadData()
        
        if !listOfWords.isEmpty {
            
            let newWord = listOfWords.remove(at: Int(arc4random_uniform(UInt32(listOfWords.count))))
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
            
        } else {
            
            enableLetterButtons(false)
            correctWordLabel.text = "<out of words>"
            treeImageView.image = UIImage(named: "apples0")
        }
    }
    
    func enableLetterButtons(_ enabled: Bool) {
        for button in letterButtons {
            button.isEnabled = enabled
        }
    }
}

