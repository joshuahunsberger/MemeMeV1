//
//  Meme.swift
//  MemeMeV1 - MemeMe 1.0
//
//  Created by Joshua Hunsberger on 11/15/15.
//  Copyright © 2015 Joshua Hunsberger. All rights reserved.
//

import UIKit

class Meme {
    var topText : String
    var bottomText : String
    var originalImage : UIImage
    // Image with overlaid text
    var memeImage : UIImage
    
    // Initializer
    init(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memeImage = memeImage
    }
    
}