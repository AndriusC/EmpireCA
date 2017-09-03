//
//  World.swift
//  EmpireCA
//
//  Created by Andrius on 9/2/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import UIKit
class World {
    var colonyNumber = 0
    let width = 1280
    let height = 720
    let backgroundImage = UIImage(named: "world_map.png")!
    var people: [[Person?]]
    let bitmap: Bitmap?
    var pixelData: CFData?
    let imageData: UnsafePointer<UInt8>!
    
    init(colonyCount: Int) {
        bitmap = Bitmap(width: width, height: height)
        pixelData = backgroundImage.cgImage!.dataProvider!.data
        imageData = CFDataGetBytePtr(pixelData)
        colonyNumber = colonyCount
        people = .init(repeating: .init(repeating: nil, count: height), count: width)
    }
    
    func startHumanity(view: UIView) {
        
        for id in 0..<colonyNumber {
            print(id)
            while true {
                let x = Int.randomValue(lessThan: width)
                let y = Int.randomValue(lessThan: height)
                let randomR = Int.randomValue(lessThan: 256)
                let randomG = Int.randomValue(lessThan: 256)
                let randomB = Int.randomValue(lessThan: 256)
                if isLandAt(x: x, y: y, in: imageData) && personAt(x: x, y: y) == nil {
                    let person = Person(colonyID: id, x: x, y: y, world: self)
                    bitmap?[x, y] = Bitmap.Pixel(r: UInt8(randomR), g: UInt8(randomG), b: UInt8(randomB), a: 255)
                    people[x][y] = person
                    
                    break // to get out of the while loop
                }
            }
        }
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(cgImage: (bitmap?.cgImage())!)
        view.insertSubview(imageView, aboveSubview: view)
        print("all done!")
    }
    
    func lifeTick(view: UIView) {
        for y in 0..<height {
            for x in 0..<width {
                if people[x][y] != nil {
                    let randomR = Int.randomValue(lessThan: 256)
                    let randomG = Int.randomValue(lessThan: 256)
                    let randomB = Int.randomValue(lessThan: 256)
                    people[x][y]!.reproductionValue = people[x][y]!.reproductionValue + 5
                    if people[x][y]?.reproductionValue == 20 {
                        let person = Person(colonyID: 1, x: x + 1, y: y + 1, world: self)
                        bitmap?[x + 1, y + 1] = Bitmap.Pixel(r: UInt8(randomR), g: UInt8(randomG), b: UInt8(randomB), a: 255)
                        people[x + 1][y + 1] = person
                        //for now its adding into one direction - into the topright corner, thats fine, Ill randomize it later
                        //add person into a random direction - up down left right, apply isLandAt and personAt == nil. If both pass, move old person there, new into the old location.
                    }
                    let imageView = UIImageView(frame: view.frame) // I know I'll  be making millons of views here but the goal is to simply keep it here
                    //so I can remember to find out how to clear the old bitmap, add a new one. If that's an efficient way of adding new pixels.
                    imageView.image = UIImage(cgImage: (bitmap?.cgImage())!)
                    view.insertSubview(imageView, aboveSubview: view)
                    print("all done!")
                }
            }
        }
    }


func personAt(x: Int, y: Int) -> Person? {
    if x > width, x < 0, y > height, y < 0 {
        return nil
    } else {
        return people[x][y]
    }
}

func isLandAt(x: Int, y: Int, in data: UnsafePointer<UInt8>) -> Bool {
    let pixelInfo = (width * y + x) * 4
    let g = data[pixelInfo + 1]
    return g > 100
}
}

extension Int {
    static func randomValue(lessThan bound: Int) -> Int {
        return Int(arc4random_uniform(UInt32(bound)))
    }
}
