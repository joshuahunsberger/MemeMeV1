//
//  MemeMeTextFieldDelegate.swift
//  MemeMeV1 - MemeMe 1.0
//
//  Created by Joshua Hunsberger on 11/14/15.
//  Copyright © 2015 Joshua Hunsberger. All rights reserved.
//

import UIKit

class MemeMeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    /* 
     * Dismisses the keyboard when the return key is pressed
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}