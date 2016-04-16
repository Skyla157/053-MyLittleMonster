//
//  RattyViewController.swift
//  053-MyLittleMonster
//
//  Created by Meagan McDonald on 4/15/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import UIKit
import AVFoundation

class RattyViewController: MasterViewController {
    
    @IBOutlet weak var rattyImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var sleepImg: DragImg!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty1Img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rattyImg.playIdleAnimation("ratty")
        
        foodImg.dropTarget = rattyImg
        heartImg.dropTarget = rattyImg
        sleepImg.dropTarget = rattyImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        randomItem()
        startTimer()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        sleepImg.alpha = DIM_ALPHA
        sleepImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            playSoundEffect("sfxRattyHeart.wav")
        } else if currentItem == 1 {
            playSoundEffect("sfxRattyBite.wav")
        } else {
            playSoundEffect("sfxRattySnore.wav")
        }
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            penalties = penalties + 1
            
            playSoundEffect("sfxSkull.wav")
            
            if penalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        
        randomItem()
    }
    
    func randomItem() {
        let rand = arc4random_uniform(3)
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
            sleepImg.alpha = DIM_ALPHA
            sleepImg.userInteractionEnabled = false
        } else if rand == 1 {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
            sleepImg.alpha = DIM_ALPHA
            sleepImg.userInteractionEnabled = false
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            sleepImg.alpha = OPAQUE
            sleepImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
    }
    
    func gameOver() {
        rattyImg.playDeathAnimation("ratty")
        playSoundEffect("sfxRattyDeath.wav")
        gameOverReset()
    }
    
}


