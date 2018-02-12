//
//  TableViewCell.swift
//  iQuiz
//
//  Created by Andre Nguyen on 2/11/18.
//  Copyright © 2018 Andre Nguyen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizName: UILabel!
    @IBOutlet weak var quizDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
