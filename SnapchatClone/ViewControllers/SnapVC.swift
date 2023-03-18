//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Andrew  on 3/16/23.
//

import UIKit

class SnapVC: UIViewController {
    
    var selectedSnap : Snap?
    var selectedTime : Int?
    
    @IBOutlet weak var timeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let time = selectedTime {
            timeLabel.text = "Time left: \(time)"
        }
        
        
    }
    

}
