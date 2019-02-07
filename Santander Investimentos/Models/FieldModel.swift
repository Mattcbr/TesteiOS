//
//  FieldModel.swift
//  Santander Investimentos
//
//  Created by Matheus Queiroz on 2/7/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class FieldModel {
    let type : Int
    let message : String
    let typeField : Int
    let hidden : Bool
    let topSpacing :Double
    let show : Int
    let id : Int
    let required : Bool
    
    
    init(receivedType: Int, receivedMessage : String, receivedTypeField : Int, receivedHidden : Bool, receivedTopSpacing :Double, receivedShow : Int, receivedId : Int, receivedRequired : Bool) {
        self.type = receivedType
        self.message = receivedMessage
        self.typeField = receivedTypeField
        self.hidden = receivedHidden
        self.topSpacing = receivedTopSpacing
        self.show = receivedShow
        self.id = receivedId
        self.required = receivedRequired
    }
}
