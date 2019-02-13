//
//  Parser.swift
//  Santander Investimentos
//
//  Created by Matheus Queiroz on 2/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class Parser {
    static let shared = Parser()
    
    func parseContactView(response: Any) -> [FieldModel] {
        var fieldsArray = [FieldModel] ()
        let JSONresponse = response as? [String : Any]
        let cells = JSONresponse?["cells"] as? [[String : Any]]
        
        cells?.forEach{ fieldInfo in
            
            let type = fieldInfo["type"] as? Int ?? 10
            let message = fieldInfo["message"] as? String ?? "Default"
            var typeField = fieldInfo["typefield"] as? Int ?? 0
            if (fieldInfo["typefield"] as? String == "telnumber"){
                typeField = 2
            }
            let hidden = fieldInfo["hidden"] as? Bool ?? false
            let topSpacing = fieldInfo["topSpacing"] as? Double ?? 10.0
            let show = fieldInfo["show"] as? Int ?? 10
            let id = fieldInfo["id"] as? Int ?? 0
            let required = fieldInfo["required"] as? Bool ?? false
            
            let newField = FieldModel(receivedType: type,
                                      receivedMessage: message,
                                      receivedTypeField: typeField,
                                      receivedHidden: hidden,
                                      receivedTopSpacing: topSpacing,
                                      receivedShow: show,
                                      receivedId: id,
                                      receivedRequired: required)
            fieldsArray.append(newField)
        }
        return fieldsArray
    }
}
