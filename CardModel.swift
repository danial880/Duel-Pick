//
//  CardModel.swift
//  duelpick
//
//  Created by GoMeat on 18/01/2020.
//  Copyright © 2020 GoMeat. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // initialize cards array to store cards
        var generatedCardsArray = [Card]()
        
        // Generate random pairs of cards
        for _ in 1...8 {
            
            //Generate a random number
            let randomNumber = arc4random_uniform(13) + 1
            
            //Create First Card Object
            let cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            generatedCardsArray.append(cardOne)
            
            //Create Second Card Object
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            generatedCardsArray.append(cardTwo)
        }
        // return the array
        return generatedCardsArray
    }
}
