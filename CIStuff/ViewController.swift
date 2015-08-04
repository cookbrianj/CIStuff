//
//  ViewController.swift
//  CIStuff
//
//  Created by Brian Cook on 8/3/15.
//  Copyright (c) 2015 Brian Cook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vImgView: UIImageView!
    
    var filters:[Filter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        filters.append(redBlueSwap())
        filters.append(setVibrance(2.0))
        
        let workingImage = ImageByApplyingFilters(filters, CIImage(image: vImgView.image))
        vImgView.image = UIImageFromCIImage(workingImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

