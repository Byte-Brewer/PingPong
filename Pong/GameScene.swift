//
//  GameScene.swift
//  Pong
//
//  Created by Nazar Prysiazhnyi on 10/26/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var orangeBall = SKSpriteNode()
    var violetBall = SKSpriteNode()
    var purpleBall = SKSpriteNode()
    var arrayOfBalls = [SKSpriteNode]()
    
    
    override func didMove(to view: SKView) {
        
        orangeBall = self.childNode(withName: "orangeBall") as! SKSpriteNode
        violetBall = self.childNode(withName: "violetBall") as! SKSpriteNode
        purpleBall = self.childNode(withName: "purpleBall") as! SKSpriteNode
        
        orangeBall.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 50))
        violetBall.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 30))
        purpleBall.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 20))
        
        
        // create 303 new copy balls
        
        for _ in 0...100 {
            let ball = (orangeBall.copy() as! SKNode)
            let ball1 = violetBall.copy()
            let ball2 = purpleBall.copy()
            self.addChild(ball)
            self.addChild(ball1 as! SKNode)
            self.addChild(ball2 as! SKNode)
            arrayOfBalls.append(ball as! SKSpriteNode)
            arrayOfBalls.append(ball1 as! SKSpriteNode)
            arrayOfBalls.append(ball2 as! SKSpriteNode)
        }
        
        // apply different impulse for Each balls
        arrayOfBalls.enumerated().forEach{$1.physicsBody?.applyImpulse(CGVector(dx: 10 + $0, dy: 30 + $0))}
        
       
        // create scene border to hold balls in scene
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
    
        self.physicsBody = border
    }
}
