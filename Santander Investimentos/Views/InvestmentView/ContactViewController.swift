//
//  ContactViewController.swift
//  Santander Investimentos
//
//  Created by Matheus Queiroz on 2/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITextFieldDelegate {

    var iteractor: ContactViewIteractor?
    var previousItem: Any?
    var viewItem: Any?
    var successView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iteractor = ContactViewIteractor(viewController: self)
        
        if #available (iOS 11.0, *){
            previousItem = view.safeAreaLayoutGuide
            viewItem = view.safeAreaLayoutGuide
        } else {
            previousItem = view
            viewItem = view
        }
        let window = UIApplication.shared.keyWindow
        successView = UIView(frame: (window?.frame)!)
    }
    
    override func viewDidLayoutSubviews() {
        view.subviews.forEach{subview in
            if let textField = subview as? UITextField {
                let lineView = CALayer()
                let width = CGFloat(2.0)
                lineView.borderColor = UIColor.lightGray.cgColor
                lineView.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
                lineView.borderWidth = width
                textField.layer.addSublayer(lineView)
                textField.layer.masksToBounds = true
            }
        }
    }
    
    func addElement(toView element: Any, topSpacing: Float, keyboardType: UIKeyboardType?, isCheckBox: Bool){
        let objectType = type(of: element)
        
        if (objectType == UITextField.self){
            let textField = element as! UITextField
            textField.delegate = self
            view.addSubview(textField)
            
            textField.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
            textField.keyboardType = keyboardType!
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            let topConstraint = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: previousItem, attribute: .bottom, multiplier: 1.0, constant: CGFloat(topSpacing))
            let leftConstraint = NSLayoutConstraint(item: textField, attribute: .left, relatedBy: .equal, toItem: viewItem, attribute: .left, multiplier: 1.0, constant: 8)
            let rightConstraint = NSLayoutConstraint(item: textField, attribute: .right, relatedBy: .equal, toItem: viewItem, attribute: .right, multiplier: 1.0, constant: -8)
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            NSLayoutConstraint.activate([topConstraint, leftConstraint, rightConstraint])
            previousItem = textField
        } else if (objectType == UILabel.self) {
            let label = element as! UILabel
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let topConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: previousItem, attribute: .top, multiplier: 1.0, constant: CGFloat(topSpacing))
            let leftConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: viewItem, attribute: .left, multiplier: 1.0, constant: 10)
            let rightConstraint = NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: viewItem, attribute: .right, multiplier: 1.0, constant: 10)
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.numberOfLines = 0
            
            NSLayoutConstraint.activate([topConstraint, leftConstraint, rightConstraint])
            previousItem = label
        } else if (objectType == UIButton.self){
            if(isCheckBox){
                let button = element as! UIButton
                let checkboxLabel = UILabel()
                checkboxLabel.text = button.titleLabel?.text
                button.titleLabel?.text = ""
                
                view.addSubview(button)
                view.addSubview(checkboxLabel)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                checkboxLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let buttonTopConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: previousItem, attribute: .bottom, multiplier: 1.0, constant: CGFloat(topSpacing))
                let buttonLeftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: viewItem, attribute: .left, multiplier: 1.0, constant: 10)
                let buttonWidthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
                let buttonHeightConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
                
                let labelTopConstraint = NSLayoutConstraint(item: checkboxLabel, attribute: .top, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1.0, constant: 0)
                let labelLeftConstraint = NSLayoutConstraint(item: checkboxLabel, attribute: .left, relatedBy: .equal, toItem: button, attribute: .right, multiplier: 1.0, constant: 5)
                let labelRightConstraint = NSLayoutConstraint(item: checkboxLabel, attribute: .right, relatedBy: .equal, toItem: viewItem, attribute: .right, multiplier: 1.0, constant: -5)

                NSLayoutConstraint.activate([buttonTopConstraint, buttonLeftConstraint, buttonWidthConstraint, buttonHeightConstraint, labelTopConstraint, labelLeftConstraint, labelRightConstraint])
                button.addTarget(self, action: #selector(didPressCheckbox), for: .touchUpInside)
                previousItem = button
            } else {
                let button = element as! UIButton
                
                button.setTitle(button.titleLabel?.text, for: .normal)
                
                view.addSubview(button)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                
                let buttonTopConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: previousItem, attribute: .bottom, multiplier: 1.0, constant: CGFloat(topSpacing))
                let buttonLeftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: viewItem, attribute: .left, multiplier: 1.0, constant: 10)
                let buttonRightContraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: viewItem, attribute: .right, multiplier: 1.0, constant: -10)
                
                NSLayoutConstraint.activate([buttonTopConstraint, buttonLeftConstraint, buttonRightContraint])
                button.addTarget(self, action: #selector(didPressSend), for: .touchUpInside)
                previousItem = button
            }
        }
    }
    
    @objc func didPressCheckbox(sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
    
    @objc func didPressSend(sender: UIButton){
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.6)
        showSuccessfullMessageSentView()
    }
    
    func showSuccessfullMessageSentView() {
        let thanksLabel = UILabel()
        let successLabel = UILabel()
        let newMessageButton = UIButton()
        
        successLabel.text = "Mensagem enviada com Sucesso :)"
        successLabel.font = successLabel.font.withSize(32)
        successLabel.textAlignment = .center
        successLabel.numberOfLines = 0
        successLabel.sizeToFit()
        thanksLabel.text = "Obrigado!"
        newMessageButton.setTitle("Enviar nova Mensagem", for: .normal)
        newMessageButton.setTitleColor(UIColor(red: 0.8549, green: 0.0039, blue: 0.0039, alpha: 1.0), for: .normal)
        newMessageButton.addTarget(self, action: #selector(resetContactView), for: .touchUpInside)
        
        successView.addSubview(thanksLabel)
        successView.addSubview(successLabel)
        successView.addSubview(newMessageButton)
        successView.backgroundColor = .white
        view.addSubview(successView)
        
        thanksLabel.translatesAutoresizingMaskIntoConstraints = false
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        newMessageButton.translatesAutoresizingMaskIntoConstraints = false
        
        thanksLabel.centerXAnchor.constraint(equalTo:successView.centerXAnchor).isActive = true
        
        let successLabelTopConstraint = NSLayoutConstraint(item: successLabel, attribute: .top, relatedBy: .equal, toItem: thanksLabel, attribute: .bottom, multiplier: 1.0, constant: 5.0)
        let successLabelRightConstraint = NSLayoutConstraint(item: successLabel, attribute: .left, relatedBy: .equal, toItem: successView, attribute: .left, multiplier: 1.0, constant: -8.0)
        let successLabelLeftConstraint = NSLayoutConstraint(item: successLabel, attribute: .right, relatedBy: .equal, toItem: successView, attribute: .right, multiplier: 1.0, constant: 8.0)
        successLabel.centerXAnchor.constraint(equalTo:successView.centerXAnchor).isActive = true
        successLabel.centerYAnchor.constraint(equalTo: successView.centerYAnchor).isActive = true
        
       let buttonBottomConstraint = NSLayoutConstraint(item: newMessageButton, attribute: .bottom, relatedBy: .equal, toItem: successView, attribute: .bottom, multiplier: 1.0, constant: -80)
        newMessageButton.centerXAnchor.constraint(equalTo:successView.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([successLabelTopConstraint, successLabelLeftConstraint, successLabelRightConstraint, buttonBottomConstraint])
    }
    
    @objc func resetContactView(sender: UIButton){
        view.subviews.forEach{ subview in
            if let textField = subview as? UITextField {
                textField.text = ""
                textField.isSelected = false
            } else if let button = subview as? UIButton {
                button.isSelected = false
                button.backgroundColor = button.backgroundColor?.withAlphaComponent(1.0)
            }
        }
        successView.removeFromSuperview()
    }
    
    @objc func textFieldEditingDidChange(sender: UITextField){
        iteractor?.textFieldDidChange(textField: sender)
    }
    
    func paintTextField(textField: UITextField, withColor: CGColor){
        
        view.subviews.forEach{ subview in
            if let textFieldInView = subview as? UITextField{
                if (textFieldInView.placeholder == textField.placeholder) {
//                    textFieldInView.layer.borderColor = withColor
                    /*let newLineView = CALayer()
                    let width = CGFloat(2.0)
                    newLineView.borderColor = withColor
                    newLineView.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
                    newLineView.borderWidth = width
                    textField.layer.addSublayer(newLineView)
                    textField.layer.masksToBounds = true*/
                }
            }
        }
    }
}
