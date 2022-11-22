//
//  GameScene.swift
//  Project 11
//
//  Created by Clément Villanueva on 02/08/2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let balls = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var restartLabel: SKLabelNode!
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var ballsLeftLabel: SKLabelNode!
    var ballsLeft = 5 {
        didSet {
            ballsLeftLabel.text = "Balls: \(ballsLeft)"
        }
    }
        
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballsLeftLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsLeftLabel.text = "Balls: 5"
        ballsLeftLabel.horizontalAlignmentMode = .right
        ballsLeftLabel.position = CGPoint(x: 980, y: 650)
        addChild(ballsLeftLabel)
        
        restartLabel = SKLabelNode(fontNamed: "Chalkduster")
        restartLabel.text = "Restart"
        restartLabel.horizontalAlignmentMode = .center
        restartLabel.position = CGPoint(x: 512, y: 700)
        addChild(restartLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.horizontalAlignmentMode = .left
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        startGame()
    }
    
    func startGame() {
        if !editingMode {
            score = 0
            ballsLeft = 5
            
            for node in children {
                if node.name == "box" {
                    node.removeFromParent()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        
        let objects = nodes(at: location)
        
        if objects.contains(editLabel) {
            editingMode.toggle()
        } else if objects.contains(restartLabel) {
            startGame()
        } else {
            if editingMode {
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                
                box.name = "box"
                
                if location.y > 600 {
                    box.position = CGPoint(x: location.x, y: 600)
                } else {
                    box.position = location
                }
                
                addChild(box)
            } else {
                if ballsLeft > 0 {
                    guard let ballName = balls.randomElement() else { return }
                    
                    let ball = SKSpriteNode(imageNamed: ballName)
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
                    ball.physicsBody?.restitution = 0.4
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.position = CGPoint(x: location.x, y: 600)
                    ball.name = "ball"
                    
                    addChild(ball)
                }
            }
        }
    }
    
    func makeBouncer(at: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        
        bouncer.position = CGPoint(x: at.x, y: at.y)
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            ballsLeft += 1
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            ballsLeft -= 1
            score -= 1
        } else if object.name == "box" {
            destroy(box: object)
        }
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
        
    func destroy(box: SKNode) {
        box.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if contact.bodyA.node?.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if contact.bodyB.node?.name == "ball" {
            collision(between: nodeB, object: nodeA)
        } else if contact.bodyA.node?.name == "box" {
            collision(between: nodeA, object: nodeB)
        } else if contact.bodyB.node?.name == "box" {
            collision(between: nodeB, object: nodeA)
        }
    }
}
