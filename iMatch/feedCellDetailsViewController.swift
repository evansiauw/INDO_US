//
//  feedCellDetailsViewController.swift
//  iMatch
//
//  Created by Iwan Siauw on 8/23/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit

class feedCellDetailsViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        navBar.topItem?.title = feedTitleDetails
    }
    
    var image: UIImage!
    var feedTitleDetails: String?
    
    @IBOutlet weak var imageView: UIImageView!
    

}
