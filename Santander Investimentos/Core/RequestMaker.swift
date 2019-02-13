//
//  RequestMaker.swift
//  Santander Investimentos
//
//  Created by Matheus Queiroz on 2/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestDelegate: class{
    func didLoadContactFields(fields:[FieldModel])
    func didFailToLoadContactFields(withError error: Error)
}

class RequestMaker {
 
    weak var delegate: RequestDelegate?
    let responseParser = Parser.shared
    
    func request(viewType type: String) {
        var requestURL = String()
        
        if(type == "Investment"){
            requestURL = "https://floating-mountain-50292.herokuapp.com/fund.json"
        } else {
            requestURL = "https://floating-mountain-50292.herokuapp.com/cells.json"
        }
        
        
        Alamofire.request(requestURL).responseJSON{ response in
            switch response.result{
                
            case .success(let JSON):
                let fieldsArray = self.responseParser.parseContactView(response: JSON)
                self.delegate?.didLoadContactFields(fields:fieldsArray)
            case .failure(let error):
                self.delegate?.didFailToLoadContactFields(withError: error)
            }
        }
    }
}
