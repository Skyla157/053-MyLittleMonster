//
//  MonsterImg.swift
//  053-MyLittleMonster
//
//  Created by Meagan McDonald on 4/12/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    var t: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func playIdleAnimation(t: String) {
        self.image = UIImage(named: "\(t)idle1.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...4 {
            let img = UIImage(named: "\(t)idle\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 //infinite
        self.startAnimating()
    }
    
    func playDeathAnimation(t: String) {
        self.image = UIImage(named: "\(t)dead5.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        
        for x in 1...5 {
            let img = UIImage(named: "\(t)dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
        
    }
    
}
