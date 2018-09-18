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
        navigationItem.title = feedTitleDetails
        feedDetails.text = feedDetail

    }
    
    var image: UIImage!
    var feedTitleDetails: String?
    var feedDetail: String?
    var feedTitle: String?
    
    @IBOutlet weak var feedDetails: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    

}
