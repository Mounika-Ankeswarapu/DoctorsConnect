//
//  AppointmentListTVC.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 20/02/25.
//

import UIKit

class AppointmentListTVC: UITableViewCell {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var appointTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
