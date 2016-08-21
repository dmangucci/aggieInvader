//
//  EndScene.swift
//  NCATspaceinvaders
//
//  Created by Dennis Azorlibu on 8/20/16.
//  Copyright © 2016 Dennis Azorlibu. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class EndScene: SKScene {
    
    
    var backGroundMusicPlayer = AVAudioPlayer()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        
        let bgMusicURL = NSBundle.mainBundle().URLForResource("dbz", withExtension: "mp3")//music name and extension
        try! backGroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL!)
        backGroundMusicPlayer.prepareToPlay()
        backGroundMusicPlayer.play()

        
        self.backgroundColor = SKColor.blueColor()
        let message = "GAMEOVER AGGIE"
        let message1 = "Tap the screen to play again"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontColor = SKColor.yellowColor()
        label.fontSize = 55
        label.position = CGPoint(x: self.size.width / 2 ,y: self.size.height / 2)
        
        let label1 = SKLabelNode(fontNamed: "Chalkduster")
        label1.text = message1
        label1.fontColor = SKColor.yellowColor()
        label1.fontSize = 30
        label1.position = CGPoint(x: self.size.width / 2 ,y: self.size.height / 8)
        
        addChild(label1)
        addChild(label)
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let transition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
        let gameScene = GameScene(size : self.size)
        self.view?.presentScene(gameScene, transition: transition)
        
       
    }
    
}

/*

class EndScene: SKScene {
    
    var restartButton : UIButton!
    var highScore : Int!
    var scoreLabel : UILabel!
    var highScoreLabel : UILabel!
    
    // var background = SKSpriteNode(imageNamed: "bgimage")
    override func didMoveToView(view: SKView) {
        
 
                
        restartButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: view.frame.size.height / 7 ))
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
        
         highScoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 3, height: 50))
        highScoreLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.width / 2)
        highScoreLabel.text = "HighScore: \(highScore)"
        self.view?.addSubview(highScoreLabel)
    }
    
    
    func Restart(){
        let gameScene = GameScene(size: self.size)
        gameScene.scaleMode = .AspectFill
        
        self.view?.presentScene(gameScene, transition: SKTransition.doorsCloseHorizontalWithDuration(0.3))

        restartButton.removeFromSuperview()
        highScoreLabel.removeFromSuperview()
        scoreLabel.removeFromSuperview()
    }
    
}*/


