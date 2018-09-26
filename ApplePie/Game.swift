//
//  Game.swift
//  ApplePie
//
//  Created by Gabriel Blaine Palmer on 9/23/18.
//  Copyright © 2018 Gabriel Blaine Palmer. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word{
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter) "
            } else {
                guessedWord += "_ "
            }
        }
        guessedWord.removeLast()
        return guessedWord
    }
}
