//
//  Question.swift
//  iQuiz
//
//  Created by Andre Nguyen on 2/18/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import Foundation

class Question {
    var answer: String
    var answers: [String]
    var text: String
    
    init(answer: String, answers: [String], text: String) {
        self.answer = answer
        self.answers = answers
        self.text = text
    }

    
}
