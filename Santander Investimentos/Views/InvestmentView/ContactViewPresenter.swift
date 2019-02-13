//
//  ContactViewPresenter.swift
//  Santander Investimentos
//
//  Created by Matheus Queiroz on 2/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import UIKit
class ContactViewPresenter{
    var controller: ContactViewController?
    
    init(viewController: ContactViewController) {
        self.controller = viewController
    }
    
    func addFieldToView(field: FieldModel){
        let textField = UITextField()
        var keyboardType: UIKeyboardType
        textField.placeholder = field.message
        switch field.typeField {
        case 1:
            keyboardType = .default
        case 2:
            keyboardType = .phonePad
        case 3:
            keyboardType = .emailAddress
        default:
            keyboardType = .default
        }
        controller?.addElement(toView: textField, topSpacing: Float(field.topSpacing), keyboardType: keyboardType, isCheckBox: false)
    }
    
    func addLabelToView(field: FieldModel){
        let label = UILabel()
        label.text = field.message
        controller?.addElement(toView: label, topSpacing: Float(field.topSpacing), keyboardType: nil, isCheckBox: false)
    }
    
    func addButtonToView(field: FieldModel){
        let button = UIButton()
        button.titleLabel?.text = field.message
        if(field.type != 5) {
            button.setImage(UIImage(named: "check_selected"), for: .selected)
            button.setImage(UIImage(named: "check_unselected"), for: .normal)
            controller?.addElement(toView: button, topSpacing: Float(field.topSpacing), keyboardType: nil, isCheckBox: true)
        } else {
            button.backgroundColor = UIColor(red: 0.8549, green: 0.0039, blue: 0.0039, alpha: 1.0)
            button.layer.cornerRadius = 18
            controller?.addElement(toView: button, topSpacing: Float(field.topSpacing), keyboardType: nil, isCheckBox: false)
        }
    }
    
    func validateNameTextField(field: UITextField){
        let textLength = field.text?.count ?? 0
        if(textLength > 0){
            controller!.paintTextField(textField: field, withColor: UIColor.green.cgColor)
        } else {
            controller!.paintTextField(textField: field, withColor: UIColor.red.cgColor)
        }
    }
}
