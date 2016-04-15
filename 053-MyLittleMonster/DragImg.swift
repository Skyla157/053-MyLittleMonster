//
//  DragImg.swift
//  053-MyLittleMonster
//
//  Created by Meagan McDonald on 4/12/16.
//  Copyright © 2016 Skyla157. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView {
    
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //grab first object in touches set
        if let touch = touches.first {
            let position = touch.locationInView(self.superview) //grab position in location of superview
            self.center = CGPointMake(position.x, position.y)   //where your finger drags, move object with it
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview?.superview)  //self.superview?.superview for both landscape and portrait
            
            if CGRectContainsPoint(target.frame, position) { //if you drop anywhere in the monster frame
                
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
                
            }
        }
        self.center = originalPosition
    }
}
