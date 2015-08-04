//
//  RedBlueSwapFilter.swift
//  CIStuff
//
//  Created by Brian Cook on 8/3/15.
//  Copyright (c) 2015 Brian Cook. All rights reserved.
//

import CoreImage

class RedBlueChannelSwapFilter: CIFilter {
    var inputImage:CIImage?
    var kernel:CIColorKernel?
    
    override init() {
        super.init()
        
        if let url = NSBundle.mainBundle().URLForResource("RedBlueSwap", withExtension: "cikernel") as NSURL! {
            var kernelSource = String(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: nil)
            var kernels =  CIKernel.kernelsWithString(kernelSource)
            kernel = kernels.first as! CIColorKernel!
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var outputImage : CIImage! {
        if let inputImage = inputImage {
            let dod = inputImage.extent()
            if let kernel = kernel {
                var args = [inputImage as AnyObject]
                return kernel.applyWithExtent(dod, arguments: args)
            }
        }
        return nil
    }
    
}
