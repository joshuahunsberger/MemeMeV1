//
//  ViewController.swift
//  MemeMeV1 - MemeMe 1.0
//
//  Created by Joshua Hunsberger on 11/8/15.
//  Copyright © 2015 Joshua Hunsberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Define Interface Builder Outlet variables
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // Set default text macro style attributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0,  // A negative value allows displaying both a fill and stroke
    ]
    
    // Instantiate the text field delegate
    let memeMeTextFieldDelegate = MemeMeTextFieldDelegate()
    
    /* Life cycle functions */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = memeMeTextFieldDelegate
        bottomTextField.delegate = memeMeTextFieldDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        // Disable camera button if camera not available on device
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Set text attributes of top and bottom text fields
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        // Center text in text fields
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        // Set default text for the labels
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        // Set text fields to clear when selected
        topTextField.clearsOnBeginEditing = true
        bottomTextField.clearsOnBeginEditing = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    
    /* ImagePickerController functions */
    
    /**
        Sets the imagePickerView's image to the image selected in the modal image
        chooser
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get original image and display it in the imagePickerView
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
        }
        
        // Dismiss image picker
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
        Dismisses the image picker
    */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the image picker
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /* Keyboard shifting functions */
    
    /**
        Moves the view up when beginning editing the bottom text field.
    
        This method is called when the UIKeyboardWillShowNotification is triggered
    */
    func keyboardWillShow(notification: NSNotification){
        if(bottomTextField.editing){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    /**
        Moves the view back down when finished editing the bottom text field.
     
        This method is called when the UIKeyboardWillHideNotification is triggered
    */
    func keyboardWillHide(notification: NSNotification){
        if(bottomTextField.editing){
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    /**
        Gets the height of the keyboard
     
        - Returns: height of keyboard as CGFloat
    */
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    /** 
        Sets up keyboard notification subscription
    */
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    /** 
        Tears down keyboard notification subscription
    */
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    /* Meme saving functions */
    
    /**
        Saves the image and text field portions of the view as a single image

        - Returns: A UIImage of the complete image macro
    */
    func generateImageMacro() -> UIImage {
        
        // Hide toolbar and navigation controller, so they are not in saved image
        toolbar.hidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let imageMacro : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Unhide the toolbar and navigation controller after capturing the image
        toolbar.hidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        return imageMacro
    }
    
    /* Interface Builder Action functions */
    
    /**
        Displays UIImagePicker for the photo library
    */
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    /** 
        Displays UIImagePicker with the source as the camera
    */
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    /**
        Displays options to the user to share the image macro "meme"
    */
    @IBAction func shareMeme(sender: UIBarButtonItem) {
    
    }
}

