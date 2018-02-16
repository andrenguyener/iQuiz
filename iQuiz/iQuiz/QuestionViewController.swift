//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Andre Nguyen on 2/15/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import UIKit

var points = 0
var questions : [String] = []

class QuestionViewController: UIViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var nextBut: UIButton!
    
    

    @IBOutlet var answerChoice: [UIButton]!
    var currentQuestion = 0
    var rightAnswerPlacement:UInt32 = 0
    var beforeTag = -1
    var currentTag = -1
    var currentButton:UIButton = UIButton()
    var answers : [[String]] = []
    var onQuestionResults = false
    var appdata = AppData.shared
    @IBOutlet weak var pageTitle: UINavigationItem!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func choicePressed(_ sender: Any) {
        if beforeTag == -1 {
            beforeTag = 0
            currentButton = sender as! UIButton
            currentButton.isSelected = true
        } else {
            currentButton.isSelected = false
            currentButton = sender as! UIButton
            currentButton.isSelected = true
        }
        currentTag = (sender as AnyObject).tag
        print(currentTag)
        nextBut.isEnabled = true
    }
    
    // function that displays new question
    func newQuestion() {
        switch(myIndex) {
        case 0 :
            pageTitle.title = appdata.quizzes[0]
            questions = appdata.mathQuestions
            answers = appdata.mathAnswers
        case 1 :
            pageTitle.title = appdata.quizzes[1]
            questions = appdata.scienceQuestions
            answers = appdata.scienceAnswers
        case 2 :
            pageTitle.title = appdata.quizzes[2]
            questions = appdata.heroQuestions
            answers = appdata.heroAnswers
        default :
            pageTitle.title = appdata.quizzes[0]
            questions = appdata.mathQuestions
            answers = appdata.mathAnswers
        }
        question.text = questions[currentQuestion]
        rightAnswerPlacement = arc4random_uniform(4) + 1
        // Create a button
        var button:UIButton = UIButton()
        var x = 1
        
        for i in 1...4 {
            // Create a button
            button = view.viewWithTag(i) as! UIButton
            if (i == Int(rightAnswerPlacement)) { // if i button index is equal to rightAnswerPlacement
                button.setTitle(answers[currentQuestion][0], for: .normal)
            } else {
                button.setTitle(answers[currentQuestion][x], for: .normal)
                x += 1
            }
        }
        currentQuestion += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        nextBut.isHidden = true
        newQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        currentButton.isSelected = false
        if onQuestionResults {
            nextQuestion()
        } else {
            if (currentTag == Int(rightAnswerPlacement)) {
                points += 1
                let green = UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                currentButton.backgroundColor = green
            } else {
                currentButton.backgroundColor = UIColor.red
                currentButton.setTitleColor(UIColor.white, for: .normal)
            }
            //        nextBut.isHidden = false
            var tempTag = 1
            for i in 1...4 {
                let button = view.viewWithTag(i) as? UIButton
                button?.isEnabled = false
                button?.setTitleColor(UIColor.white, for: .normal)
                if (i == Int(rightAnswerPlacement)) {
                    let green = UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1.0)
                    button?.backgroundColor = green
                    onQuestionResults = true
                    nextBut.setTitle("next", for: .normal)
                }
                tempTag += 1
            }
        }
//        nextQuestion()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        performSegue(withIdentifier: "backHome", sender: self)
        points = 0
    }
    
    func nextQuestion() {
        if (currentQuestion != questions.count) {
            newQuestion()
            currentButton.isSelected = false
            onQuestionResults = false
            //            currentButton.backgroundColor = UIColor.clear
            for i in 1...4 {
                let button = view.viewWithTag(i) as? UIButton
                button?.isEnabled = true
                button?.backgroundColor = UIColor.clear
                let color = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
                button?.setTitleColor(color, for: .normal)
            }
        } else {
            performSegue(withIdentifier: "results", sender: self)
        }
//        nextBut.isHidden = true
    }
    
}
