//
//  VariableCell.swift
//  NSCodingObject Generator
//
//  Created by André Traleski de Campos on 9/7/15.
//  Copyright (c) 2015 André Traleski de Campos. All rights reserved.
//

import UIKit

class VariableCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var optionalSwitch: UISwitch!

    override func awakeFromNib() {
        
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }
    
}
