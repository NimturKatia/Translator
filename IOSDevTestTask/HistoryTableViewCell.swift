//
//  HistoryTableViewCell.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/4/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var inputTextLabel: UILabel!
    @IBOutlet weak var outputTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with model: HistoryModel){
        let date       = convertDateToString(date: model.date!)
        let inputText  = model.inputText
        let outputText = model.outputText
        
        self.dateLabel.text       = date
        self.inputTextLabel.text  = inputText
        self.outputTextLabel.text = outputText
    }
    
    func convertDateToString(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from:date)
        return(dateString)
    }
}
