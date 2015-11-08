//
//  ViewController.swift
//  MemeMeV1 - MemeMe 1.0
//
//  Created by Joshua Hunsberger on 11/8/15.
//  Copyright © 2015 Joshua Hunsberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Define IBOutlet variables
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // Set default text macro style attributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0,  // A negative value allows displaying both a fill and stroke
    ]
    
    override func viewWillAppear(animated: Bool) {
        // Disable camera button if camera not available on device
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Set text attributes of top and bottom text fields
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        // Center text in text fields
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        // Set text fields to clear when selected
        topTextField.clearsOnBeginEditing = true
        bottomTextField.clearsOnBeginEditing = true
        
        // Set default text for the labels
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }

    
}

