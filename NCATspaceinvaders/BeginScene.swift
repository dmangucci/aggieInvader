//
//  beginSwift.swift
//  NCATspaceinvaders
//
//  Created by Dennis Azorlibu on 8/21/16.
//  Copyright © 2016 Dennis Azorlibu. All rights reserved.
//

import SpriteKit
import AVFoundation

class BeginScene: SKScene {
    
        var backgroundMusicPlayer = AVAudioPlayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize){
        super.init(size: size)
        

            
            let bgMusicURL = NSBundle.mainBundle().URLForResource("ncat", withExtension: "mp3")//music name and extension
            try! backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL!)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()

    
        //skView.ignoreSiblingOrder = true
       // self.view!.backgroundColor = UIColor(patternImage: UIImage(named: "bg.png")!)
        
        backgroundColor = SKColor.yellowColor()
        
        let background = SKSpriteNode(imageNamed: "aggie.png")
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        addChild(background)
        
        let message = "START"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 300
        label.position = CGPoint(x: self.size.width / 2 ,y: self.size.height / 5)
        
        addChild(label)
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let transition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
        let doors = SKTransition.crossFadeWithDuration(0.3)
        let gameScene = GameScene(size : self.size)
        self.view?.presentScene(gameScene, transition: doors)
        
        
       
    }
    
}
