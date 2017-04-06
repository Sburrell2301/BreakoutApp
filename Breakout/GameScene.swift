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
        if isPlaying == true {
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
        makeAllBricks()
        
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
        
       else if contact.bodyA.node?.name == "bricks" || contact.bodyB.node?.name == "bricks" {
            print("You win!")
            bricks.removeFromParent()
            score += 1
            displayScoreLabel()
        }
        
        else if contact.bodyA.node?.name == "brick1" || contact.bodyB.node?.name == "brick1" {
            print("You win!")
            brick1.removeFromParent()
            score += 1
            displayScoreLabel()
        }
        
       else if contact.bodyA.node?.name == "brick2" || contact.bodyB.node?.name == "brick2" {
            print("You win!")
            brick2.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick3" || contact.bodyB.node?.name == "brick3" {
            print("You win!")
            brick3.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick4" || contact.bodyB.node?.name == "brick4" {
            print("You win!")
            brick4.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick5" || contact.bodyB.node?.name == "brick5" {
            print("You win!")
            brick5.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick6" || contact.bodyB.node?.name == "brick6" {
            print("You win!")
            brick6.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick7" || contact.bodyB.node?.name == "brick7" {
            print("You win!")
            brick7.removeFromParent()
            score += 1
            displayScoreLabel()
        }
       else if contact.bodyA.node?.name == "brick8" || contact.bodyB.node?.name == "brick8" {
            print("You win!")
            brick8.removeFromParent()
            score += 1
            displayScoreLabel()
        }
        if score == 10 {
            resetGame()
            updateLabels()
            isPlaying = false
            
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
        bricks = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        bricks.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        bricks.position = CGPoint(x: frame.midX + 76, y: frame.maxY - 30)
        bricks.physicsBody?.isDynamic = false
        bricks.name = "bricks"
        addChild(bricks)

    }
    
    func makeBrick1() {
        brick1 = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick1.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick1.position = CGPoint(x: frame.midX + 152, y: frame.maxY - 30)
        brick1.physicsBody?.isDynamic = false
        brick1.name = "brick1"
        addChild(brick1)
    }
    
    func makeBrick2() {
        brick2 = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick2.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick2.position = CGPoint(x: frame.midX - 76, y: frame.maxY - 30)
        brick2.physicsBody?.isDynamic = false
        brick2.name = "brick2"
        addChild(brick2)
    }
    
    func makeBrick3() {
        brick3 = SKSpriteNode(color: UIColor.blue, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick3.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick3.position = CGPoint(x: frame.midX - 152, y: frame.maxY - 30)
        brick3.physicsBody?.isDynamic = false
        brick3.name = "brick3"
        addChild(brick3)
    }
    
    func makeBrick4() {
        brick4 = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick4.position = CGPoint(x: frame.midX, y: frame.maxY - 75)
        brick4.name = "brick4"
        brick4.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick4.physicsBody?.isDynamic = false
        addChild(brick4)
    }
    
    func makeBrick5() {
        brick5 = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick5.position = CGPoint(x: frame.midX + 76, y: frame.maxY - 75)
        brick5.name = "brick5"
        brick5.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick5.physicsBody?.isDynamic = false
        addChild(brick5)
    }
    
    func makeBrick6() {
        brick6 = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick6.position = CGPoint(x: frame.midX + 152, y: frame.maxY - 75)
        brick6.name = "brick6"
        brick6.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick6.physicsBody?.isDynamic = false
        addChild(brick6)
    }
    
    func makeBrick7() {
        brick7 = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick7.position = CGPoint(x: frame.midX - 76, y: frame.maxY - 75)
        brick7.name = "brick7"
        brick7.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick7.physicsBody?.isDynamic = false
        addChild(brick7)
    }
    
    func makeBrick8() {
        brick8 = SKSpriteNode(color: UIColor.red, size: CGSize (width: frame.width/5, height: frame.height/25))
        brick8.position = CGPoint(x: frame.midX - 152, y: frame.maxY - 75)
        brick8.name = "brick8"
        brick8.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick8.physicsBody?.isDynamic = false
        addChild(brick8)
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
