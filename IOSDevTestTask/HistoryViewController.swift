//
//  HistoryViewController.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/4/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var historyTableView: UITableView!

    var historyItemsArray = [HistoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Translations history"
        self.historyTableView.register(UINib.init(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyItemCell")
        self.loadData()
        self.historyItemsArray.reverse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "historyItemCell", for: indexPath) as? HistoryTableViewCell)!
        cell.configureCell(with: historyItemsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = historyItemsArray[indexPath.row]
        
        let inputText  = model.inputText ?? ""
        let outputText = model.outputText ?? ""
        
        let attributedInputText  = NSAttributedString.init(string: inputText, attributes: [NSFontAttributeName: UIFont.init(name: "Optima", size: 17)!])
        let attributedOutputText = NSAttributedString.init(string: outputText, attributes: [NSFontAttributeName: UIFont.init(name: "Optima", size: 17)!])
        
        let inputTextRect  = attributedInputText.boundingRect(with: CGSize.init(width: self.view.frame.width - 16, height: 0), options: .usesLineFragmentOrigin, context: nil)
        let outputTextRect = attributedOutputText.boundingRect(with: CGSize.init(width: self.view.frame.width - 16, height: 0), options: .usesLineFragmentOrigin, context: nil)
        
        let tableRowHeight = inputTextRect.height + outputTextRect.height + 45 + 5 * 8
        
        return tableRowHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.historyItemsArray.remove(at: indexPath.row)
            self.historyTableView.deleteRows(at: [indexPath], with: .right)
            self.deleteHistoryItem(indexPath: indexPath)
        }
    }
    
    func loadData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context =  appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Consts.historyEntity)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if !results.isEmpty {
                for result in results {
                    let model = HistoryModel()
                    
                    model.date       = (result as AnyObject).value(forKey: Consts.date) as? Date
                    model.inputText  = (result as AnyObject).value(forKey: Consts.inputText) as? String
                    model.outputText = (result as AnyObject).value(forKey: Consts.outputText) as? String
                    
                    self.historyItemsArray.append(model)
                }
            }
        } catch {
            
        }
    }
    
    func deleteHistoryItem(indexPath: IndexPath){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context     = appDelegate.persistentContainer.viewContext
        
        let historyFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Consts.historyEntity)
        historyFetchRequest.includesPropertyValues = false
        
        do {
            let row = historyItemsArray.count - indexPath.row
            let historyItems = try context.fetch(historyFetchRequest) as! [NSManagedObject]
            context.delete(historyItems[row])
            try context.save()
        } catch {
            
        }
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
