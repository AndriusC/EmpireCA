//
//  People.swift
//  EmpireCA
//
//  Created by Andrius on 9/1/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import UIKit


class Person {
    var age = 0
    var strength: Int
    var reproductionValue: Int
    var colonyID: Int
    var isAlive: Bool
    var isDiseased: Bool
    var x: Int
    var y: Int
    var canMakeChild: Bool
    
    init(newColonyID: Int, xNew: Int, yNew: Int) {
        colonyID = newColonyID
        reproductionValue = 0
        x = xNew
        y = yNew
        isAlive = true
        strength = Int(arc4random_uniform(100))
        isDiseased = false
        canMakeChild = false
        let diseasedChance = arc4random_uniform(100)
        if diseasedChance == 99{
            isDiseased = true
        }
    }
    
    init(childOf parent: Person, xNew: Int, yNew: Int, newColonyID: Int) {
        colonyID = newColonyID
        reproductionValue = 0
        x = xNew
        y = yNew
        isAlive = true
        strength = parent.strength + .randomValue(lessThan: 20)
        isDiseased = false
        canMakeChild = false
        let diseasedChance = arc4random_uniform(100)
        if diseasedChance == 99{
            isDiseased = true
        }
    }
    
    func makeChild(childOf: Person, xNew: Int, yNew: Int, newColonyID: Int) {
        let child = childOf
        child.age = 0
        child.reproductionValue = 0
        child.isAlive = true
        child.isDiseased = false
        child.canMakeChild = false
        child.strength = childOf.strength
        child.x = xNew
        child.y = yNew
    }
    func kill() {
        age = 0
        reproductionValue = 0
        isAlive = false
        isDiseased = false
        canMakeChild = false
        strength = 0
        x = 0
        y = 0
        colonyID = 0
    }
    func update(world: World) {
        
        
        
        if age > strength {
            //   isAlive = false
            //return
        }
        if isDiseased {
            let randomChanceToDie = Int(arc4random_uniform(100))
            if randomChanceToDie == 100 {
                //  isAlive = false
                //  return
            }
        }
        let randomX = Int(arc4random_uniform(2))
        let randomX2 = Int(arc4random_uniform(2))
        let randomY = Int(arc4random_uniform(2))
        let randomY2 = Int(arc4random_uniform(2))
        let generatedX = x + (randomX - randomX2)
        let generatedY = y + (randomY - randomY2)
        
        
        age = age + 1
        reproductionValue += 1
        if reproductionValue < 2 {
            canMakeChild = false
        }
        if reproductionValue >= 2 {
            if world.isLandAt(x: generatedX, y: generatedY) || world.personAt(x: generatedX, y: generatedY) != nil {
                canMakeChild = true
                let child = Person(childOf: self, xNew: self.x, yNew: self.y, newColonyID: self.colonyID)
                world.people[child.x][child.y] = child
    
                x = generatedX
                y = generatedY
                reproductionValue = 0
                world.people[x][y] = self
            }
            
        }
    }
}
