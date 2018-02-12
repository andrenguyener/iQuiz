//
//  AppData.swift
//  iQuiz
//
//  Created by Andre Nguyen on 2/11/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import Foundation
import UIKit

class AppData : NSObject {
    static let shared = AppData()
    open var quizzes : [String] = ["Mathematics", "Heroes", "Science"]
    open var images : [String] = ["mathematics.jpeg", "heroes.png", "science.png"]
    open var descriptions : [String] = ["A very mathy math math", "Heroes go vroom vroom in me mums car", "Inertia is a property of matter. Science rocks!"]
    
    func getQuizzes() -> [String] {
        return quizzes
    }
    
}
