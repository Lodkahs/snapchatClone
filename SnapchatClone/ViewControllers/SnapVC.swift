//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Andrew  on 3/16/23.
//

import UIKit
import ImageSlideshow
import Kingfisher

class SnapVC: UIViewController {
    
    var selectedSnap : Snap?
    var selectedTime : Int?
    var inputArray = [KingfisherSource]()
    
    @IBOutlet weak var timeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let time = selectedTime {
            timeLabel.text = "Time left: \(time)"
        }
        
        if let snap = selectedSnap {
            
            for imageURL in snap.imageUrlArray {
                
                inputArray.append(KingfisherSource(urlString: imageURL)!)
                
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.9))
            imageSlideShow.backgroundColor = UIColor.white
            
            let indicator = UIPageControl()
            indicator.currentPageIndicatorTintColor = UIColor.lightGray
            indicator.pageIndicatorTintColor = UIColor.black
            imageSlideShow.pageIndicator = indicator
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel)
        }
        
        
    }
    

}
