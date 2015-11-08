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
    
    override func viewWillAppear(animated: Bool) {
        // Disable camera button if camera not available on device
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        
    }

    
}

