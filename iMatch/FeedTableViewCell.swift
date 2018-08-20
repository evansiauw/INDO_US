//
//  FeedTableViewCell.swift
//  iMatch
//
//  Created by Iwan Siauw on 8/19/18.
//  Copyright © 2018 Iwan Siauw. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedTitle: UILabel!
    @IBOutlet weak var feedSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
