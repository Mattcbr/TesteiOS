//
//  ContactViewInteractor.swift
//  Santander Investimentos
//
//  Created by Matheus Queiroz on 2/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit

class ContactViewIteractor: RequestDelegate{
    var controller: ContactViewController?
    var presenter: ContactViewPresenter?
    var fieldsArray = [FieldModel]()
    
    var requestHandler = RequestMaker()
    
    init(viewController: ContactViewController) {
        self.controller = viewController
        
        requestHandler.delegate = self
        requestHandler.request(viewType: "Contacts")
        
        presenter = ContactViewPresenter(viewController: viewController)
    }
    
    func didLoadContactFields(fields: [FieldModel]) {
        fields.forEach { newField in
            switch newField.type{
            case 1:
                //Field
                print("Field")
                presenter?.addFieldToView(field: newField)
            case 2:
                //Text
                print("Text")
                presenter?.addLabelToView(field: newField)
            case 3:
                //Image
                print("Image")
            case 4:
                //Checkbox
                print("Checkbox")
                presenter?.addButtonToView(field: newField)
            case 5:
                //Send
                print("Send")
                presenter?.addButtonToView(field: newField)
            default:
                //Error
                print("Error")
            }
        }
    }
    
    func didFailToLoadContactFields(withError error: Error) {
        print("Faiô")
    }
    
    func textFieldDidChange(textField: UITextField){
        let type = textField.placeholder
        if (type == "Nome completo"){
            presenter?.validateNameTextField(field: textField)
        } else if (type == "Email"){
            
        } else if (type == "Telefone"){
            
        }
    }
}
