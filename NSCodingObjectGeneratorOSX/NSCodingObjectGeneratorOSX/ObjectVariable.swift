//
//  ObjectVariable.swift
//  NSCodingObjectGeneratorOSX
//
//  Created by Pablo Henemann on 09/12/15.
//  Copyright (c) 2015 Pablo Henemann. All rights reserved.
//

import Cocoa

class ObjectVariable {
    
    var name: String!
    var type: String!
    var optional: Bool!
    
    var isNew: Bool = true
    
    init(name: String = "", type: String = "", optional: Bool = true) {
        
        self.name = name
        self.type = type
        self.optional = optional
        
    }
    
}
