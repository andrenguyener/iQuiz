//
//  ViewController.swift
//  iQuiz
//
//  Created by Andre Nguyen on 2/10/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//
import UIKit
 var myIndex = 0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var appdata = AppData.shared
    var jsonTextField: UITextField?
    @IBOutlet weak var tableView: UITableView!
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData(jsonLink: appdata.urlText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appdata.topics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let topicObj = appdata.topics[indexPath.row]
        cell.quizImage.image = UIImage(named: "\(topicObj.img)")
        cell.quizName.text = "\(topicObj.title)"
        cell.quizDesc.text = "\(topicObj.desc)"
        return cell
    }
    
    @IBAction func SettingsPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings", message: "Place custom json url", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: jsonTextField)
        let checkNowAction = UIAlertAction(title: "Check Now", style: .default, handler: self.checkNow)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(checkNowAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func jsonTextField(textField: UITextField!) {
        jsonTextField = textField
        jsonTextField?.placeholder = "http://tednewardsandbox.site44.com/questions.json"
    }
    
    func checkNow(action: UIAlertAction!) {
        print((jsonTextField?.text)!)
        self.appdata.urlText = (jsonTextField?.text)!
        getData(jsonLink: self.appdata.urlText)
    }
    
    func checkReachability() -> Bool {
        if currentReachabilityStatus == .reachableViaWiFi {
            print("User is connected to the internet via wifi.")
        }else if currentReachabilityStatus == .reachableViaWWAN{
            print("User is connected to the internet via WWAN.")
        } else {
            let alertController = UIAlertController(title: "WiFi", message: "You are not connected to Internet", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        if currentReachabilityStatus == .reachableViaWiFi || currentReachabilityStatus == .reachableViaWWAN {
            return true
        } else {
            return false
        }
    }
    
    func showQuizInformation(JSONResult: NSArray) {
        UserDefaults.standard.set(JSONResult, forKey: "QuestionsJSON")
        let data = UserDefaults.standard.object(forKey: "QuestionsJSON") as! NSArray
        var idx = 0
        for i in data {
            let object = i as AnyObject
            let title = object["title"] as! String
            let desc = object["desc"] as! String
            let tempQuestions = object["questions"] as! NSArray
            var questions: [Question] = []
            for questionObject in tempQuestions {
                let q = questionObject as AnyObject
                let answer = q["answer"] as! String
                let answers = q["answers"] as! [String]
                let text = q["text"] as! String
                let question = Question(answer: answer, answers: answers, text: text)
                questions.append(question)
            }
            let topic: Topic = Topic(title: title, desc: desc, img: self.appdata.images[idx], questions: questions)
            self.appdata.topics.append(topic)
            idx += 1
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadLocalJSONFile(filename: String) {
        if let path = Bundle.main.path(forResource: "\(filename)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                UserDefaults.standard.set(jsonResult, forKey: "QuestionsJSON")
                self.showQuizInformation(JSONResult: jsonResult as! NSArray)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    @objc func getData(jsonLink: String) {
        self.appdata.topics.removeAll()
        let url = URL(string: jsonLink.trimmingCharacters(in: .whitespacesAndNewlines))
        if checkReachability() && jsonLink.count > 0 {
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "JSON Fail", message: "Unable to download data", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    self.appdata.urlText =  "http://tednewardsandbox.site44.com/questions.json"
                    self.loadLocalJSONFile(filename: "questions")
                } else {
                    
                    if let content = data {
                        do {
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                            UserDefaults.standard.set(myJson, forKey: "QuestionsJSON")
                            let data = UserDefaults.standard.object(forKey: "QuestionsJSON") as! NSArray
                            var idx = 0
                            for i in data {
                                let object = i as AnyObject
                                let title = object["title"] as! String
                                let desc = object["desc"] as! String
                                let tempQuestions = object["questions"] as! NSArray
                                var questions: [Question] = []
                                for questionObject in tempQuestions {
                                    let q = questionObject as AnyObject
                                    let answer = q["answer"] as! String
                                    let answers = q["answers"] as! [String]
                                    let text = q["text"] as! String
                                    let question = Question(answer: answer, answers: answers, text: text)
                                    questions.append(question)
                                }
                                let topic: Topic = Topic(title: title, desc: desc, img: self.appdata.images[idx], questions: questions)
                                self.appdata.topics.append(topic)
                                print (topic.description)
                                idx += 1
                            }
                        } catch {
                            print("Catch")
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } else {
                        print("Error")
                    }
                }
            }
            task.resume()
        } else {
            self.loadLocalJSONFile(filename: "questions")
        }
        tableView.reloadData()
    }


}

