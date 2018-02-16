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
    open var quizzes : [String] = ["Mathematics", "Science", "Heroes"]
    open var images : [String] = ["mathematics.jpeg", "science.png", "heroes.png"]
    open var descriptions : [String] = ["A very mathy math math", "Inertia is a property of matter. Science rocks!", "Heroes go vroom vroom in me mums car"]
    
    open var mathQuestions = [
        "1 + 1 = ?",
        "13892 / 4 = ?"
    ]
    
    open var mathAnswers = [
        ["2", "1", "3", "4"],
        ["3473", "3278", "3710", "3211"]
    ]
    
    open var scienceQuestions = [
        "What is Space?",
        "What is a rock?"
    ]
    
    open var scienceAnswers = [
        ["A big black thing", "I don't know", "Where rockets fly", "The final frontier"],
        ["Something I throw at my neighbors", "Something hard", "Solid mineral material", "A type of music"]
    ]
    
    open var heroQuestions = [
        "What is Superman's Weakness?",
        "How old is Spiderman?"
    ]
    
    open var heroAnswers = [
        ["Kryptonite", "Cheese Cake", "Batman", "Nothing"],
        ["15", "13", "28", "17"]
    ]
    
}
