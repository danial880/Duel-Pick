//
//  CardCollectionViewCell.swift
//  duelpick
//
//  Created by GoMeat on 18/01/2020.
//  Copyright © 2020 GoMeat. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func setCard(_ card: Card) {
        
        // Keep track of the card that gets passed in
        self.card = card
        
        
        // If card is Matched, make images invisible
        if card.isMatched == true {
            
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }
        else {
            
            // If card does not match, make images visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        // Determine if the card is flipped up or flipped down
        if card.isFlipped == true {
            
            // Make sure front image is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            
            // Make sure back image is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip() {
        
        // Flip image from back to front
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        
        // Flip from front to back
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
        
    }
    
    func remove() {
        
        // Remove both imageviews from being visible
        backImageView.alpha = 0
        
        // TODO: Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
}
