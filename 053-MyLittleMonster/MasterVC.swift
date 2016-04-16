//
//  MasterVC.swift
//  053-MyLittleMonster
//
//  Created by Meagan McDonald on 4/15/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import UIKit
import AVFoundation

class MasterViewController: UIViewController {
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var backgroundMusicPlayer = AVAudioPlayer()
    var soundFX: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBackgroundMusic("cave-music.mp3")        
    }
    
    func playSoundEffect(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            soundFX = try AVAudioPlayer(contentsOfURL: newURL)
            if soundFX.playing {
                soundFX.stop()
            }
            soundFX.prepareToPlay()
            soundFX.play()
        } catch let error as NSError {
            print(error.description)
        }
        
    }
    
    func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()  //reset existing timer
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func gameOverReset() {
        backgroundMusicPlayer.stop()
        timer.invalidate()
        delay(3) {
            self.performSegueWithIdentifier("GameOver", sender: self)
        }
    }
    

}
