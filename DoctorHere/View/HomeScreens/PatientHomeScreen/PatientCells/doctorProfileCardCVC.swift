//
//  doctorProfileCardCVC.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 18/02/25.
//

import UIKit

class doctorProfileCardCVC: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var doctorLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 15
    }

}
