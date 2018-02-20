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
    open var topics: [Topic] = []
    open var urlText = "http://tednewardsandbox.site44.com/questions.json"
    open var images : [String] = ["science.png", "heroes.png", "mathematics.jpeg"]
}
