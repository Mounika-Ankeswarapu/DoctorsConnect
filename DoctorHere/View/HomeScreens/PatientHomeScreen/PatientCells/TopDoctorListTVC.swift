//
//  TopDoctorListTVC.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 19/02/25.
//

import UIKit
import HCSStarRatingView

class TopDoctorListTVC: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var docNameLbl: UILabel!
    @IBOutlet weak var docSpecificationLbl: UILabel!
    @IBOutlet weak var starRatingView: HCSStarRatingView!
    @IBOutlet weak var numOfReviewsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 12
        imgView.layer.cornerRadius = 15
        starRatingView.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
