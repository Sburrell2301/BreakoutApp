//
//  GameScene.swift
//  Breakout
//
//  Created by Sam Burrell on 3/13/17.
//  Copyright © 2017 Sam Burrell. All rights reserved.
//

import SpriteKit
import GameplayKit

var ball = SKShapeNode()
var paddle = SKSpriteNode()
var brick = SKSpriteNode()
var playLabel = SKLabelNode()
var livesLabel = SKLabelNode()
var scoreLabel = SKLabelNode()
var score = 0
var lives = 3
var bricks = SKSpriteNode()
var brick1 = SKSpriteNode()
var brick2 = SKSpriteNode()
var brick3 = SKSpriteNode()
var brick4 = SKSpriteNode()
var brick5 = SKSpriteNode()
var brick6 = SKSpriteNode()
var brick7 = SKSpriteNode()
var brick8 = SKSpriteNode()
var isPlaying = false


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        createBackground()
        resetGame()
        makeLoseZone()
        livesLabeles()
        displayScoreLabel()
        if isPlaying == false {
            displayPlayLabel()
        }
        else {
            playLabel.removeFromParent()
        }
        
  
    }
    func kickBall() {
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 3))
    }
    
    func resetGame() {
        ball.removeFromParent()
        makeBall()
        paddle.removeFromParent()
        makePaddle()
        makeBrick()
        makeBricks()
        makeBrick1()
        makeBrick2()
        makeBrick3()
        makeBrick4()
        makeBrick5()
        makeBrick6()
        makeBrick7()
        makeBrick8()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches {
            let location = touch.location(in: self)
            paddle.position.x = location.x
            
            for node in nodes(at: location) {
                if node.name == "play" {
                    kickBall()
                    isPlaying = true
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "brick" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
        
       else if contact.bodyA.node?.name == "bricks" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
        
        else if contact.bodyA.node?.name == "brick1" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
        
       else if contact.bodyA.node?.name == "brick2" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick3" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick4" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick5" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick6" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick7" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick8" || contact.bodyB.node?.name == "brick" {
            print("You win!")
            brick.removeFromParent()
            score += 1
            displayScoreLabel()
        }
        
        if contact.bodyA.node?.name == "loseZone" || contact.bodyB.node?.name == "brick" {
            print("You lose!")
            ball.removeFromParent()
            lives -= 1
            livesLabeles()
            if lives == 0 {
                resetGame()
                updateLabels()
                isPlaying = false
            }
            else {
                makeBall()
                kickBall()
            }
        }
    }
    
    func createBackground() {
        let stars = SKTexture(imageNamed: "stars")
        for i in 0...1 {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x: 0, y: starsBackground.size.height * CGFloat(i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy(x: 0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsBackground.run(moveForever)
        }
    }
    
    func makeBall() {
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        ball.strokeColor = UIColor.black
        ball.fillColor = UIColor.yellow
        ball.name = "ball"
        // physics shape matches ball image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // ignores all forces and impulses
        ball.physicsBody?.isDynamic = false
        // use precise collision detection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        // no loss of energy from friction
        ball.physicsBody?.friction = 0
        // gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        // bounces fully off of other objects
        ball.physicsBody?.restitution = 1
        // does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        addChild(ball) // add ball object to the view
    }
    
    func makePaddle() {
        paddle = SKSpriteNode(color: UIColor.white, size: CGSize(width: frame.width/4, height: frame.height/25))
        paddle.position = CGPoint(x: frame.midX, y: frame.minY + 125)
        paddle.name = "paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }
    
    func makeAllBricks() {
        makeBrick()
        makeBricks()
        makeBrick1()
        makeBrick2()
        makeBrick3()
        makeBrick4()
        makeBrick5()
        makeBrick6()
        makeBrick7()
        makeBrick8()
    }

    func makeBrick() {
        brick = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.position = CGPoint(x: frame.midX, y: frame.maxY - 30)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
        
    }

    func makeBricks() {
        brick = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.position = CGPoint(x: frame.midX + 76, y: frame.maxY - 30)
        brick.physicsBody?.isDynamic = false
        brick.name = "bricks"
        addChild(brick)

    }
    
    func makeBrick1() {
        brick = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.position = CGPoint(x: frame.midX + 152, y: frame.maxY - 30)
        brick.physicsBody?.isDynamic = false
        brick.name = "brick1"
        addChild(brick)
    }
    
    func makeBrick2() {
        brick = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.position = CGPoint(x: frame.midX - 76, y: frame.maxY - 30)
        brick.physicsBody?.isDynamic = false
        brick.name = "brick2"
        addChild(brick)
    }
    
    func makeBrick3() {
        brick = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.position = CGPoint(x: frame.midX - 152, y: frame.maxY - 30)
        brick.physicsBody?.isDynamic = false
        brick.name = "brick3"
        addChild(brick)
    }
    
    func makeBrick4() {
        brick = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.position = CGPoint(x: frame.midX, y: frame.maxY - 75)
        brick.name = "brick4"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    
    func makeBrick5() {
        brick = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.position = CGPoint(x: frame.midX + 76, y: frame.maxY - 75)
        brick.name = "brick5"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    
    func makeBrick6() {
        brick = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.position = CGPoint(x: frame.midX + 152, y: frame.maxY - 75)
        brick.name = "brick6"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    
    func makeBrick7() {
        brick = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.position = CGPoint(x: frame.midX - 76, y: frame.maxY - 75)
        brick.name = "brick7"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    
    func makeBrick8() {
        brick = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick.position = CGPoint(x: frame.midX - 152, y: frame.maxY - 75)
        brick.name = "brick8"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    

    func makeLoseZone() {
        let loseZone = SKSpriteNode(color: UIColor.red, size: CGSize(width: frame.width, height: 50))
        loseZone.position = CGPoint(x: frame.midX, y: frame.minY - 30)
        loseZone.name = "loseZone"
        loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
        loseZone.physicsBody?.isDynamic = false
        addChild(loseZone)
    }
    
    func livesLabeles() {
       let livesLabels = SKLabelNode(fontNamed: "Arial")
        livesLabels.text = "Lives: \(lives)"
        livesLabels.position = CGPoint(x: frame.minX + 40, y: frame.minY + 10)
        livesLabels.name = "livesLabels"
        livesLabels.color = UIColor.white
        livesLabels.fontSize  = 20
        addChild(livesLabels)
        
    }
    
    func displayScoreLabel() {
        let scoreLabels = SKLabelNode(fontNamed: "Arial")
        scoreLabels.text = "Score: \(score)"
        scoreLabels.position = CGPoint(x: frame.maxX - 40, y: frame.minY + 10)
        scoreLabels.fontColor = UIColor.white
        scoreLabels.name = "scoreLabels"
        scoreLabels.fontSize = 20
        addChild(scoreLabels)
    }
    
    func displayPlayLabel() {
        let playLabels = SKLabelNode(fontNamed: "Arial")
        playLabels.position = CGPoint(x: frame.midX, y: frame.midY)
        playLabels.text = "Tap to start playing"
        playLabels.fontColor = UIColor.white
        playLabels.fontSize = 40
        playLabels.name = "play"
        addChild(playLabels)
    }
    
    func updateLabels() {
        score = 0
        lives = 3
        livesLabeles()
        displayScoreLabel()
    }
}
