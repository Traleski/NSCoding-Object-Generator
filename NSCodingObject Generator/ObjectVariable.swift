//
//  ObjectVariable.swift
//  NSCodingObject Generator
//
//  Created by André Traleski de Campos on 9/7/15.
//  Copyright (c) 2015 André Traleski de Campos. All rights reserved.
//

import Foundation

class ObjectVariable {
    
    var name: String?
    var type: String?
    var optional: Bool?
    
    init(name: String? = nil, type: String? = nil, optional: Bool? = nil) {
        
        self.name = name
        self.type = type
        self.optional = optional
        
    }
    
}