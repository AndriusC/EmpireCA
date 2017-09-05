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
    var strength: Int?
    var reproductionValue: Int?
    var colonyID: Int?
    var isAlive: Bool?
    var isDiseased: Bool?
    var x: Int?
    var y: Int?
    init(colonyID: Int, xNew: Int, yNew: Int) {
        x = xNew
        y = yNew
        isAlive = true
        strength = Int(arc4random_uniform(100))
        isDiseased = false
        let diseasedChance = arc4random_uniform(100)
        if diseasedChance == 99{
            isDiseased = true
        }
    }
    func update() {
        if age > strength! {
            isAlive = false
            return
        }
        if isDiseased! {
            let randomChanceToDie = Int(arc4random_uniform(100))
            if randomChanceToDie == 100 {
                isAlive = false
                return
            }
        }
        age = age + 1
        if reproductionValue == 0 {
        reproductionValue = reproductionValue! + 1
        } else {
            reproductionValue = 0
        }
   //     let randomX = Int(arc4random_uniform(2))
     //   let randomX2 = Int(arc4random_uniform(2))
       // let randomY = Int(arc4random_uniform(2))
        //let randomY2 = Int(arc4random_uniform(2))
        if x == 1280 {
        x = x! - 1
        } else {
            x = x! + 1
        }
        if y == 720 {
            y = y! - 1
        } else {
        y = y! + 1
        }
        
    }
}
