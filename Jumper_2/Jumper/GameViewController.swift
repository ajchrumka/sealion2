//
//  GameViewController.swift
//  Jumper
//
//  Created by USER on 09/09/2018.
//  Copyright © 2018 LearnAppMaking. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var timerValue: UILabel!
    // added the following as part of Mark's update
    var clicks = Array<Int>()
    var clickCount = 0
//    var scene:GKScene!
//    var sceneNode:GameScene?
    //
    var tapCount = 0
    var countDown = 5
    var gameTimer = 30
    var startTimer = Timer()
    var timeRemaining = Timer()
    var valueMessage = "Click to start"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        
        countDown = 5
        gameTimer = 30
        
        valueMessage = "Click to start"
        timerValue.text = valueMessage

        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        // including entities and graphs.
         if let scene = GKScene(fileNamed: "GameScene") {
//        scene = GKScene(fileNamed: "GameScene")

            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.size = CGSize(width: 1536, height: 2048) // AJC added to follow Solo Mission Tutorial
                
                // Copy gameplay related content over to the scene
                // sceneNode.entities = scene.entities
                // sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                sceneNode.userData = NSMutableDictionary()
                sceneNode.userData?.setObject(tapCount, forKey: "tapCount" as NSCopying)
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    @objc func startGameTimer() {
        countDown -= 1
        switch countDown {
        case 3:
            valueMessage = "Click to start"
        case 2:
            valueMessage = "Ready"
        case 1:
            valueMessage = "Set"
        case 0:
            valueMessage = "Go"
            startTimer.invalidate()
            timeRemaining = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.playGameTimer), userInfo: nil, repeats: true)
        default:
            valueMessage = "Click to start"
        }
        timerValue.text = valueMessage
    }

    @objc func playGameTimer() {
        gameTimer -= 1
        timerValue.text = String(gameTimer)
        if gameTimer == 0 {
            timeRemaining.invalidate()
            performSegue(withIdentifier: "FinishGame", sender: self)
            
        }
    }
    
    @objc func addToTouchCount() {
        tapCount += 1
    }
    
    @objc func getTapCount() -> Int {
        return tapCount
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
