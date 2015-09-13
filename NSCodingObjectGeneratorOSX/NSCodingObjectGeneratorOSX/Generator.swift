//
//  Generator.swift
//  NSCodingObjectGeneratorOSX
//
//  Created by Pablo Henemann on 09/12/15.
//  Copyright (c) 2015 Pablo Henemann. All rights reserved.
//

import Cocoa

@objc(Generator)
class Generator: NSViewController {
    
    @IBOutlet var classNameTextField: NSTextField!
    @IBOutlet var codeTextView: NSTextView!
    
    var variables: [ObjectVariable] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        variables.append(ObjectVariable(name: "integer", type: "Int", optional: true))
        variables.append(ObjectVariable(name: "string", type: "String", optional: true))
        variables.append(ObjectVariable(name: "float", type: "Float", optional: true))
        variables.append(ObjectVariable(name: "double", type: "Double", optional: true))
        variables.append(ObjectVariable(name: "custom", type: "User", optional: true))
        self.generateCode()
        // Do view setup here.
        
    }
    
}

extension Generator {
    
    func generateCode() {
        
        let className = classNameTextField.stringValue
        
        var classText = ""
        classText += "import Foundation\n\n"
        classText += "class " + className + ": NSObject, NSCoding {\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "  var " + objectVar.name! + ": " + objectVar.type!
            if objectVar.optional! {
                
                varDeclare += "?\n"
                
            } else {
                
                varDeclare += "!\n"
                
            }
            
            classText += varDeclare
            
        }
        
        classText += "\n" +
        "   init("
        
        var index = 0
        for objectVar in variables {
            
            var varDeclare = objectVar.name! + ": " + objectVar.type!
            if objectVar.optional! {
                
                varDeclare += "?"
                
            }
            
            if index != variables.count - 1 {
                
                varDeclare += ", "
                
            }
            
            classText += varDeclare
            index++
            
        }
        
        classText += ") {\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "          self." + objectVar.name! + " = " + objectVar.name! + "\n"
            classText += varDeclare
            
        }
        
        classText += "\n" +
        "       }\n\n"
        classText += "      convenience required init(coder decoder: NSCoder) {\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "          let " + objectVar.name! + " = decoder.decodeObjectForKey(\"" + objectVar.name! + "\") as"
            if objectVar.optional! {
                
                varDeclare += "? "
                
            } else {
                
                varDeclare += "! "
                
            }
            
            varDeclare += objectVar.type! + "\n"
            
            classText += varDeclare
            
        }
        
        classText += "\n" +
        "           self.init("
        
        index = 0
        for objectVar in variables {
            
            var varDeclare = objectVar.name! + ": " + objectVar.name!
            
            if index != variables.count - 1 {
                
                varDeclare += ", "
                
            }
            
            classText += varDeclare
            index++
            
        }
        
        classText += ")\n\n" +
        "       }\n\n"
        classText += "      func encodeWithCoder(coder: NSCoder) {\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "          coder.encodeObject(" + objectVar.name! + ", forKey: \"" + objectVar.name! + "\")\n"
            classText += varDeclare
            
        }
        
        classText += "\n" +
            "       }\n\n" +
        "}"
        codeTextView.string = classText
        println(classText)
        
    }
    
}