//
//  Game.swift
//  Apple Pie
//
//  Created by Zhanna on 6/14/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation


struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var formattedWord: String {
        var guesstedWord = ""
        
        for letter in word{
             
            if guesstedLetters.contains(letter){
                guesstedWord += "\(letter)"
            }
            else{
                guesstedWord += "_ "
            }
        }
        
        return guesstedWord
    }
    
    var guesstedLetters:[Character]
    
    mutating func playerGuessed(letter:Character){
        guesstedLetters.append(letter)
        
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
}
