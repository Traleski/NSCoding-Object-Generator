//
//  ViewController.swift
//  NSCodingObject Generator
//
//  Created by André Traleski de Campos on 9/7/15.
//  Copyright (c) 2015 André Traleski de Campos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var codeTextView: UITextView!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    var variables: [ObjectVariable] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func addCellButtonTouched(sender: AnyObject) {
        
        let blankVariable = ObjectVariable()
        variables.append(blankVariable)
        tableView.reloadData()
        
    }
    
    @IBAction func generateButtonTouched(sender: AnyObject) {
        
        if classNameTextField.text != "" {
            
            warningLabel.hidden = true
            tableView.reloadData()
            
            var index = 0
            for objectVar in variables {
                
                if objectVar.name == nil || objectVar.type == nil {
                    
                    variables.removeAtIndex(index)
                    tableView.reloadData()
                    
                }
                
                index++
                
            }
            
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "generateCode", userInfo: nil, repeats: false)
            
        } else {
            
            warningLabel.hidden = false
            
        }
        
    }
    
    @IBAction func selectAllButtonTouched(sender: AnyObject) {
        
        codeTextView.becomeFirstResponder()
        codeTextView.selectedTextRange = codeTextView.textRangeFromPosition(codeTextView.beginningOfDocument, toPosition: codeTextView.endOfDocument)
        
    }
    
    //MARK: TextField
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        tableView.reloadData()
        
    }
    
    //MARK: TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return variables.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VariableCell", forIndexPath: indexPath) as! VariableCell
        let objectVariable = variables[indexPath.row]
        
        if cell.nameTextField.text != "" {
            
            variables[indexPath.row].name = cell.nameTextField.text
            
        } else if let name = objectVariable.name {
            
            cell.nameTextField.text = name
            
        }
        
        if cell.typeTextField.text != "" {
            
            variables[indexPath.row].type = cell.typeTextField.text
            
        } else if let type = objectVariable.type {
            
            cell.typeTextField.text = type
            
        }
        
        objectVariable.optional = cell.optionalSwitch.on
        
        
        return cell
        
    }

    
    //MARK: Private
    
    func generateCode() {
        
        let className = classNameTextField.text
        
        var classText = ""
        classText += "#import Foundation\n\n"
        classText += "class " + className + ": NSObject, NSCoding {\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "  var " + objectVar.name! + ": " + objectVar.type!
            if objectVar.optional! {
                
                varDeclare += "?\n"
                
            } else {
                
                varDeclare += "\n"
                
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
        
        classText += ")\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "      self." + objectVar.name! + " = " + objectVar.name! + "\n"
            classText += varDeclare
            
        }
        
        classText += "\n" +
        "   }\n\n"
        classText += "  convenience required init(coder decoder: NSCoder) {\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "      let " + objectVar.name! + " = decoder.decodeObjectForKey(\"" + objectVar.name! + "\") as"
            if objectVar.optional! {
                
                varDeclare += "? "
                
            } else {
                
                varDeclare += "! "
                
            }
            
            varDeclare += objectVar.type! + "\n"
            
            classText += varDeclare
            
        }
        
        classText += "\n" +
        "       self.init("
        
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
        "   }\n\n"
        classText += "  func encodeWithCoder(coder: NSCoder) {\n\n"
        
        for objectVar in variables {
            
            var varDeclare = "      coder.encodeObject(" + objectVar.name! + ", forKey: \"" + objectVar.name! + "\")\n"
            classText += varDeclare
            
        }
        
        classText += "\n" +
            "   }\n\n" +
        "}"
        
        codeTextView.text = classText
        println(classText)
        
    }

}

