//
//  GameScene.swift
//  NCATspaceinvaders
//
//  Created by Dennis Azorlibu on 8/20/16.
//  Copyright (c) 2016 Dennis Azorlibu. All rights reserved.
//

import SpriteKit
import AVFoundation

struct PhysicsCategory {
    static let enemy : UInt32 = 1; //000000000000000001
    static let bullet : UInt32  = 2; //0000000000000010
    static let player : UInt32 = 3; //00000000000000011
}




class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var highScore = Int()
    var life = 3 //Number of Lives for player
    var score = Int() // keeps score of amount of enemy killed
    var lifeLabel = UILabel() //Label for Life
    var scoreLabel = UILabel() //Label for our score
    var player = SKSpriteNode(imageNamed : "Attacker.png") //declared player variable
    
    //allows to add music to game
    var backgroundMusicPlayer = AVAudioPlayer()
    
    
    override init(size: CGSize){
        super.init(size: size)
        
        let bgMusicURL = NSBundle.mainBundle().URLForResource("bgMusic", withExtension: "mp3")//music name and extension
        try! backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL!)
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self;
        
        self.scene?.backgroundColor = UIColor.blueColor()
        
        self.scene?.size = CGSize(width: 640, height : 1136)
        
        self.addChild(SKEmitterNode(fileNamed: "MagicParticle")!)
    
        
        
        var highScoreDefault = NSUserDefaults.standardUserDefaults()
        if(highScoreDefault.valueForKey("highScore") != nil){
            highScore = highScoreDefault.valueForKey("highScore") as! NSInteger //setting highscore
        }else{
            highScore = 0
        }
        
        //determined location of player on view
        player.position = CGPointMake(self.size.width / 2,self.size.height / 11)
        
        //adding physics body to player
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.affectedByGravity = false; //we dont want gravity to affect our player
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.enemy //we want to check if we are colliding with enemy
        player.physicsBody?.dynamic = false; //no useless thing to happen, this lets bullet avoid player so we set it false
        
        
        
        //timer to depict where bullets get created and interval between
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: Selector("spawnBullets"), userInfo: nil, repeats: true)
        
       //timer to depict when enemies spawn and intervals in bwtween
        var enemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("spawnEnemies"), userInfo: nil, repeats: true)
        
        self.addChild(player)
        
        lifeLabel.text = "\(life)"
        lifeLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 50, height: 20))
        lifeLabel.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.6, alpha: 0.3)
        lifeLabel.textColor = UIColor.yellowColor()
        
        scoreLabel.text = "\(score)"
        scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        scoreLabel.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.6, alpha: 0.3)
        scoreLabel.textColor = UIColor.yellowColor()
        
        self.view?.addSubview(scoreLabel) //adding UI Label to scene
        self.view?.addSubview(lifeLabel) //adding UI Label to scene
    }
    
    //triggers the physics of something actually happening
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
        
        if ((firstBody.categoryBitMask == PhysicsCategory.enemy) && (secondBody.categoryBitMask == PhysicsCategory.bullet))||((firstBody.categoryBitMask == PhysicsCategory.bullet) && (secondBody.categoryBitMask == PhysicsCategory.enemy)){
            CollisionWithBullet(firstBody.node as! SKSpriteNode, bullet: secondBody.node as! SKSpriteNode)
        }else if ((firstBody.categoryBitMask == PhysicsCategory.enemy) && (secondBody.categoryBitMask == PhysicsCategory.player))||((firstBody.categoryBitMask == PhysicsCategory.player) && (secondBody.categoryBitMask == PhysicsCategory.enemy)){
            CollisionWithPlayer(firstBody.node as! SKSpriteNode, player: secondBody.node as! SKSpriteNode)
        }
    }
    
    //function we will call once enemy and bullet collides
    func CollisionWithBullet(enemy: SKSpriteNode, bullet:SKSpriteNode){
        enemy.removeFromParent()
        bullet.removeFromParent()
        score +=  10
        scoreLabel.text = "Score: \(score)"
       
    }
    
    func CollisionWithPlayer(enemy:SKSpriteNode, player:SKSpriteNode){
        var scoreDefault = NSUserDefaults.standardUserDefaults()
        scoreDefault.setValue(score, forKey: "score")
        scoreDefault.synchronize()
        
        life--
        lifeLabel.text = "Life: \(life)"
        
        if(score > highScore){
            var highScoreDefault = NSUserDefaults.standardUserDefaults()
            highScoreDefault.setValue(score, forKey: "highScore")
        }
        
        if (life == 0){
            player.removeFromParent()
            enemy.removeFromParent()
            self.view?.presentScene(EndScene())
            scoreLabel.removeFromSuperview()
            lifeLabel.removeFromSuperview()
            backgroundMusicPlayer.stop()
        }
        
        
        
    }
    
    
    //function to use the spawn the bullets
    func spawnBullets(){
        
        var bullet = SKSpriteNode(imageNamed: "bullet.png") //calls bullet png and sets to bullet
        bullet.zPosition = -5 //places bullet position on zaxis so as to appear that it is behind the player
        bullet.position = CGPointMake(player.position.x, player.position.y) //placing the bullet at the same axis as player
        
        //Speed at which bullets are flying out of the scene
        let action = SKAction.moveToY(self.size.height + 30, duration: 0.8)
        let actionDone  = SKAction.removeFromParent()
        bullet.runAction(SKAction.sequence([action, actionDone]))
        
        //add action to value so it moves to the y value
        //bullet.runAction(SKAction.repeatActionForever(action)) no longer need
        
        //add physics to bullet
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.bullet //bullet connected to integer
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.enemy //make sure bullet is contacting enemy
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.dynamic = false
        
        
        self.addChild(bullet)
        
    }
    
    //function to use to spawn enemies
    func spawnEnemies(){
        
        var enemy = SKSpriteNode(imageNamed: "enemy.png")
        var minValue = self.size.width / 8 //taking screen size and /8
        var maxValue  = self.size.width - 20 //so it doesnt go off the scene
        var spawnPoint = UInt32( maxValue - minValue) //for presicison
        enemy.position = CGPoint(x: CGFloat(arc4random_uniform(spawnPoint)),y: self.size.height)
        
        
        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.enemy
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.bullet
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.dynamic = true //bullets bounce of enemies
        
        
        let action = SKAction.moveToY(-30, duration: 3.0)
        let actionDone = SKAction.removeFromParent()
        enemy.runAction(SKAction.sequence([action,actionDone]))
        
        
        self.addChild(enemy) //adding child to scene
        
    }
    
    //Depicts what happens when the player is touched
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
            
            
        }
    }
   
    //Allows the player movement to be draggable, allows to move without dissapearing
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
            
        }
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
