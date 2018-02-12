//
//  ViewController.swift
//  iQuiz
//
//  Created by Andre Nguyen on 2/10/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var appdata = AppData.shared
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
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
        return appdata.quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.quizImage.image = UIImage(named: appdata.images[indexPath.row])
        cell.quizName.text = appdata.quizzes[indexPath.row]
        cell.quizDesc.text = appdata.descriptions[indexPath.row]
        return cell
    }
    
    @IBAction func SettingsPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }


}

