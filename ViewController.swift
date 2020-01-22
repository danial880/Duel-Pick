//
//  ViewController.swift
//  duelpick
//
//  Created by GoMeat on 18/01/2020.
//  Copyright © 2020 GoMeat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Calling Model
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstCardFlippedIndex:IndexPath?
    var timer:Timer?
    var milliseconds:Float = 10 * 1000 // 10 Seconds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
   // MARK: - Timer Methods
    
    @objc func timerElapsed() {
        
        milliseconds-=1
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        // Set Label
        timeLabel.text = "Time Remaining = \(seconds)"
        
        // When the timer has reached 0...
        if milliseconds <= 0 {
            
            // Stop the timer
            timer?.invalidate()
            timeLabel.textColor = UIColor.red
            
            // Check if there any cards left unmatched
            checkGameEnded()
        }
    }
    
    //MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a CardCollectionViewCard object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card that Collection View trying to display
        let card = cardArray[indexPath.row]
        
        // Set the card for cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Check if there's any time left
        //if milliseconds <= 0 {
          //  return
       // }
        
        // Get the cell that user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get the card that user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
        
            // Flip the card
            cell.flip()
            
            // Set the status of card
            card.isFlipped = true
            
            // Determine it was first or second card flipped over
            if firstCardFlippedIndex == nil {
                
            // This is the first card being flipped
                firstCardFlippedIndex = indexPath
            }
            else {
                
                // This is the second card being flipped
                
                //Perform the matching logic
                checkForMatches(indexPath)
            }
        }
        
        
    }// End of didSelectItemAt method
    
    //MARK: - Game Logic Methods
    
    func checkForMatches(_ secondCardFlippedIndex: IndexPath) {
        
        // Get the cells for two cards revealed
        let cardOneCell = collectionView.cellForItem(at: firstCardFlippedIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondCardFlippedIndex) as? CardCollectionViewCell
        
        // Get the cards for Two Cards revealed
        let cardOne = cardArray[firstCardFlippedIndex!.row]
        let cardTwo = cardArray[secondCardFlippedIndex.row]
        
        // Compare the Two Cards
        if cardOne.imageName == cardTwo.imageName {
            
            // It's a match
            
            // Set the statuses of cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            
            // Remove the cards from grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // Check Any cards left unmatched
            checkGameEnded()
        }
        else {
            
            // It's not a match
            
            // Set statuses of cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip back cards
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        // tell collectionView to reload first card cell if it is nil
        if cardOneCell == nil {
             
            // Reloading Cell
            collectionView.reloadItems(at: [firstCardFlippedIndex!])
        }
        
        // Reset the property that tracks first card flipping
        firstCardFlippedIndex = nil
    }
    
    func checkGameEnded() {
        
    }
    
} // End ViewController class

