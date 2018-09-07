//
//  feedCellDetailsViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 8/23/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit

class feedCellDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        navItem.title = feedTitleDetails

    }
    
    var image: UIImage!
    var feedTitleDetails: String = "Title"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navItem: UINavigationItem!
    

}
