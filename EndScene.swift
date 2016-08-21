//
//  EndScene.swift
//  NCATspaceinvaders
//
//  Created by Dennis Azorlibu on 8/20/16.
//  Copyright © 2016 Dennis Azorlibu. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene: SKScene {
    
    var restartButton : UIButton!
    var highScore : Int!
    var scoreLabel : UILabel!
    var highScoreLabel : UILabel!
    
    // var background = SKSpriteNode(imageNamed: "bgimage")
    override func didMoveToView(view: SKView) {
        
        
                
        restartButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 10))
        restartButton.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 7)
        
        restartButton.setTitle("Restart", forState: UIControlState.Normal)
        restartButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        restartButton.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(restartButton)
        
        
        var scoreDefault = NSUserDefaults.standardUserDefaults()
        var score = scoreDefault.valueForKey("score") as! NSInteger

        
        var highScoreDefault = NSUserDefaults.standardUserDefaults()
        highScore = highScoreDefault.valueForKey("highScore") as! NSInteger
        
         scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        scoreLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 4)
        scoreLabel.text = "Score: \(score)"
        self.view?.addSubview(scoreLabel)
        
         highScoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 30))
        highScoreLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 2)
        highScoreLabel.text = "HighScore: \(highScore)"
        self.view?.addSubview(highScoreLabel)
    }
    
    
    func Restart(){
        let gameScene = GameScene(size: self.size)
        gameScene.scaleMode = .AspectFill
        
        self.view?.presentScene(gameScene, transition: SKTransition.doorsCloseHorizontalWithDuration(0.3))

        //self.view?.presentScene(GameScene(),transition: SKTransition.crossFadeWithDuration(0.3))
        restartButton.removeFromSuperview()
        highScoreLabel.removeFromSuperview()
        scoreLabel.removeFromSuperview()
    }
    
}