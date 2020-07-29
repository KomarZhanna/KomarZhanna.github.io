//
//  CardModel.swift
//  MatchApp
//
//  Created by Zhanna on 7/27/20.
//  Copyright © 2020 Zhanna. All rights reserved.
//

import Foundation

class CardModel {
    func getCards() -> [Card] {
        
        // Declare an empry array
        
         var generateCards = [Card]()
        
        // Randomly generate 8 pairs of cards
        
        repeat
{
            // Generate random number
            
            let randomNumber = Int.random(in: 1...13)
            
            // Check for duplicates
            
    if !generateCards.contains(where: { $0.imageName == "card\(randomNumber)"}) {
                
            // Create two new card objects
            
            let cardOne = Card()
            let cardTwo = Card()
            
            // Set their image names
            
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            // Add them to the array
            
            generateCards.append(cardOne)
            generateCards.append(cardTwo)
            
            print(randomNumber)
            }
    
        }
         while generateCards.count != 16
        // Randomize the cards within array
        
        generateCards.shuffle()
        
        
        
        // Return the array
        
        return generateCards
    }
}
