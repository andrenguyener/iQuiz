//
//  ResultsViewController.swift
//  iQuiz
//
//  Created by Andre Nguyen on 2/15/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    
    @IBOutlet weak var resultScore: UILabel!
    var appdata = AppData.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        if points / questions.count == 1 {
            resultScore.text = "Amazing!!!! You got \(points)/\(questions.count)"
        } else if Double(points) / Double(questions.count) >= 0.5 {
            resultScore.text = "You did aight! You got \(points)/\(questions.count)"
        }  else {
            resultScore.text = "You Suck! You got \(points)/\(questions.count)"
        }
        points = 0
    }
    

    @IBAction func returnPressed(_ sender: Any) {
        performSegue(withIdentifier: "results", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
