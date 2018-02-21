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
var questionArray = [Question(answer: "", answers: [""], text: "" )] // array of questions
var topic : Topic = Topic(title: "", desc: "", img: "", questions: questionArray) //
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
    
    var topicObj : Topic = Topic(title: "", desc: "", img: "", questions: []) // get Topic object
    var questionObj : Question = Question(answer: "", answers: [""], text: "")
    
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
        topicObj = appdata.topics[myIndex]
        pageTitle.title = topicObj.title
        questionArray = topicObj.questions
        let singleQuestion = questionArray[currentQuestion]
        answers = [singleQuestion.answers]
        question.text = singleQuestion.text
        // Create a button
        var button:UIButton = UIButton()
        var x = 1
        
        for i in 1...4 {
            button = view.viewWithTag(i) as! UIButton
            button.setTitle(singleQuestion.answers[x - 1], for: .normal)
            x += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        if onQuestionResults {
            nextQuestion()
        } else {
            currentButton.isSelected = false
            print(currentQuestion)
            if (currentTag == Int(questionArray[currentQuestion].answer)!) {
                points += 1
                let green = UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1.0)
//                currentButton.backgroundColor = green
                currentButton.backgroundColor = UIColor.orange
            } else {
                currentButton.backgroundColor = UIColor.red
                currentButton.setTitleColor(UIColor.white, for: .normal)
            }
            var tempTag = 1
            for i in 1...4 {
                let button = view.viewWithTag(i) as? UIButton
                button?.isEnabled = false
                button?.setTitleColor(UIColor.white, for: .normal)
                if (i == Int(questionArray[currentQuestion].answer)) {
                    let green = UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1.0)
//                    button?.backgroundColor = green
                    button?.backgroundColor = UIColor.orange
                    onQuestionResults = true
                    nextBut.setTitle("next", for: .normal)
                }
                tempTag += 1
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        performSegue(withIdentifier: "backHome", sender: self)
        points = 0
    }
    
    func nextQuestion() {
        if (currentQuestion != appdata.topics[myIndex].questions.count - 1) {
            currentQuestion += 1
            newQuestion()
            currentButton.isSelected = false
            onQuestionResults = false
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
    }
    
}
