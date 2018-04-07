//
//  SliderImages.swift
//  800Handyman
//
//  Created by Tanvir Hasan Piash on 5/4/18.
//  Copyright © 2018 Tanvir Hasan Piash. All rights reserved.
//

import UIKit

class SliderImages: NSObject {
    
    private var _image: String
    
    var image: String {
        get {
            return _image
        }
    }
    
    init(image: String) {
        self._image = image
    }
    
}
