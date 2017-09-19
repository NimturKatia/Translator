//
//  TranslatorViewController.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/1/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit
import CoreData

class TranslatorViewController: UIViewController {
    @IBOutlet weak var inputTextLanguageLabel: UILabel!
    @IBOutlet weak var outputTextLanguageLabel: UILabel!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var switchLanguagesButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var translatorScrollView: UIScrollView!
    @IBOutlet weak var historyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        StyleConfigs.shared.configureButton(button: self.translateButton)
        StyleConfigs.shared.configureButton(button: self.switchLanguagesButton)
        StyleConfigs.shared.configureButton(button: self.historyButton)
        
        inputTextView.layer.borderColor = UIColor.lightGray.cgColor
        outputTextView.layer.borderColor = UIColor.lightGray.cgColor
        inputTextView.layer.borderWidth = 1
        outputTextView.layer.borderWidth = 1
        
        self.translatorScrollView.keyboardDismissMode = .interactive
        self.navigationItem.title = "Translator"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTranslateButtonPress(_ sender: UIButton) {
        if !self.inputTextView.text.isEmpty {
            let inputText = self.inputTextView.text
            if self.inputTextLanguageLabel.text == "English" {
                ServerManager.shared.getTranslatedText(text: inputText!, translateFromLanguage: "en", translateToLanguage: "uk", completion: {
                    result in
                    if !result.isEmpty {
                        let translatedText = result[0]
                        self.outputTextView.text = translatedText
                        self.saveDataToDatabase(inputText: inputText!, outputText: translatedText)
                    }
                })
            } else {
                ServerManager.shared.getTranslatedText(text: inputText!, translateFromLanguage: "uk", translateToLanguage: "en", completion: {
                    result in
                    if !result.isEmpty {
                        let translatedText = result[0]
                        self.outputTextView.text = translatedText
                        self.saveDataToDatabase(inputText: inputText!, outputText: translatedText)
                    }
                })
                
            }
        }
    }
    
    @IBAction func onSwitchLanguagesButtonPress(_ sender: UIButton) {
        if self.inputTextLanguageLabel.text == "English" {
            self.inputTextLanguageLabel.text = "Ukrainian"
            self.outputTextLanguageLabel.text = "English"
        } else {
            self.inputTextLanguageLabel.text = "English"
            self.outputTextLanguageLabel.text = "Ukrainian"
        }
    }
    
    @IBAction func onHistoryButtonPress(_ sender: UIButton) {
        let historyVC = HistoryViewController()
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    func saveDataToDatabase(inputText: String, outputText: String){
        let currentDate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context =  appDelegate.persistentContainer.viewContext
        
        let newTranslation = NSEntityDescription.insertNewObject(forEntityName: Consts.historyEntity, into: context)
        newTranslation.setValue(currentDate, forKey: Consts.date)
        newTranslation.setValue(inputText, forKey: Consts.inputText)
        newTranslation.setValue(outputText, forKey: Consts.outputText)
        
        do {
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
