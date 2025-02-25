//
//  SuccessBookingViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 21/02/25.
//

import UIKit

class SuccessBookingViewController: UIViewController {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var msgLbl: UILabel!
    
    var selectedDate: String?
    var selectedTime: String?
    var selectedTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        infoView.layer.cornerRadius = 12
        
        msgLbl.text = "Date: \(selectedDate ?? "")\n\nTime: \(selectedTime ?? "")\n\nService: \(selectedTitle ?? "")"
        msgLbl.numberOfLines = 0
        msgLbl.textAlignment = .center
       
    }
    
    @IBAction func topBackBtnAction(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(homePage, animated: true)
    }
}
