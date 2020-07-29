//
//  ViewController.swift
//  Apple Pie
//
//  Created by Zhanna on 6/14/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["кавун","банан","вертоліт","гномик","хатина","стіл","квітка"]
    
    let incorrectMovesAllowed =  7
    
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    
    
    
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
     
    var currentGame: Game!
    @IBOutlet weak var treeImageView: UIImageView!
     
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        newRound()
    }

    func newRound(){
        if !listOfWords.isEmpty {
        
        let newWord = listOfWords.removeFirst()
        
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guesstedLetters: [])
        
        for buttons in letterButtons{
            buttons.isEnabled = true
        }
            
        }
        else {
            for buttons in letterButtons{
                buttons.isEnabled = false
            }
        }
            updateUI()
    }
    
    func updateUI() {
         
        let imageName = "Tree \(currentGame.incorrectMovesRemaining)"
        let image = UIImage(named: imageName)
        
        treeImageView.image = image
        
        correctWordLabel.text = currentGame.formattedWord
        
        
        scoreLabel.text = "Wins: \(totalWins ), loses: \(totalLosses)"
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        
        let letterString = sender.title(for: .normal)!
        
        let letter = Character(letterString.lowercased())
     
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        
        if currentGame.incorrectMovesRemaining < 1{
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }
        else{
         updateUI()
    }
    }
    
}

