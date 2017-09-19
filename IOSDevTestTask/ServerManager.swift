//
//  ServerManager.swift
//  IOSDevTestTask
//
//  Created by macMini on 9/4/17.
//  Copyright © 2017 macMini. All rights reserved.
//

import UIKit
import Alamofire

class ServerManager: NSObject {
    static let shared = ServerManager()
    
    func getTranslatedText(text: String, translateFromLanguage: String, translateToLanguage: String, completion: @escaping(_ result: [String]) -> Void) {
        let url = "https://translation.googleapis.com/language/translate/v2"
        let parameters = [Consts.text: text, Consts.sourceLanguage: translateFromLanguage, Consts.targetLanguage: translateToLanguage, Consts.key: Consts.apiKey]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: {
            response in
            var result = [String]()
            
            if let JSON = response.result.value as? [String: Any]{
                if let data  = JSON[Consts.data] as? [String: Any] {
                    let textTranslations = Array(data.values)
                    let translation      = textTranslations[0]
                    let downcasted       = translation as! [[String: Any]]
                    let translatedText = Array(downcasted[0].values)
                        result = translatedText as! [String]
                }
            }
            completion(result)
        })
    }
}
