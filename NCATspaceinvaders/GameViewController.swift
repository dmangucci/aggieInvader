//
//  GameViewController.swift
//  NCATspaceinvaders
//
//  Created by Dennis Azorlibu on 8/20/16.
//  Copyright (c) 2016 Dennis Azorlibu. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

        override func viewWillLayoutSubviews(){
            super.viewWillLayoutSubviews()
            
            var skView = self.view as! SKView
            
            if skView.scene == nil {
                //var backgroundImageView = UIImageView(image: UIImage(named: "bg.png"))
                //view.addSubview(backgroundImageView)
                //backgroundImageView = UIImageView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: 25, height: 25))
                //let beginScene = BeginScene(size: CGSize (width:1024 , height: 728))
                
                skView.showsFPS = false
                skView.showsNodeCount = false
                
                //let beginScene = BeginScene(size: skView.bounds.size)
                let beginScene = BeginScene(size: CGSize (width:1100, height: 2000))
                beginScene.scaleMode = .AspectFill
                //skView.ignoresSiblingOrder = true
                skView.presentScene(beginScene)
                
            }
            
            
            
        
    }
    


    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask { //handles view orientation
        return UIInterfaceOrientationMask.Portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
