//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Andrew  on 3/17/23.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var feedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
