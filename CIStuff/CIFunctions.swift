//
//  CIFunctions.swift
//  CIStuff
//
//  Created by Brian Cook on 8/3/15.
//  Copyright (c) 2015 Brian Cook. All rights reserved.
//

import UIKit
import Foundation
import CoreImage

//This code is based on code from objc.io, check out the Functional Programming in Swift Book: http://www.objc.io/books/fpinswift

typealias Filter = CIImage -> CIImage

//because stretching is bad, this is just a temp fix
func UIImageFromCIImage(image: CIImage) -> UIImage {
    UIGraphicsBeginImageContext(image.extent().size)
    UIImage(CIImage: image)!.drawInRect(CGRectMake(0.0, 0.0, image.extent().size.width, image.extent().size.height))
    let outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage
}

func ImageByApplyingFilters(filters: Array<Filter>, image: CIImage) -> CIImage {
    let sumImage = filters.reduce(image, combine: { (image, filter) in
        filter(image)
    })
    return sumImage
}

func setVibrance(vibrance:Float) -> Filter {
    return { image in
        let filter = CIFilter(name: "CIVibrance", withInputParameters: ["inputAmount": NSNumber(float: vibrance), kCIInputImageKey: image])
        return filter.outputImage
    }
}

//This filter uses a custom CIKernel to swap the red and blue channels, a common task in infrared photo processing
func redBlueSwap() -> Filter {
    return { image in
        let filter = RedBlueChannelSwapFilter()
        filter.inputImage = image
        return filter.outputImage
    }
}