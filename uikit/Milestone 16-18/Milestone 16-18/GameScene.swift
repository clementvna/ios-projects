//
//  GameScene.swift
//  Milestone 16-18
//
//  Created by Clément Villanueva on 31/08/2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var isGameOver = false
    
    var gameTimer: Timer?
    
    var possibleTargets = ["penguinGood", "penguinEvil"]
    var linesY = [200, 400, 600]
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 15, y: 15)
        addChild(scoreLabel)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
        
        score = 0
    }

    @objc func createTarget() {
        guard let target = possibleTargets.randomElement() else { return }
        
        if !isGameOver {
            let sprite = SKSpriteNode(imageNamed: target)
            let position = CGPoint(x: 1200, y: linesY.randomElement()!)
            sprite.position = position
            addChild(sprite)
            
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 1
            sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
            sprite.physicsBody?.linearDamping = 0
            sprite.physicsBody?.angularDamping = 0
        }
    }
    
}
